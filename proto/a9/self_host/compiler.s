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
    adr x0, Functional
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
    str x0, [sp, #-16]!
    adr x0, Compiler
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
    adr x0, Code
    str x0, [sp, #-16]!
    adr x0, Generator
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, Transforms
    str x0, [sp, #-16]!
    adr x0, AST
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
    adr x0, from
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
    adr x0, parser
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
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_26
    tst x1, #1
    b.eq do_concat_26
do_apply_25:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_27
do_concat_26:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_27:
    str x0, [sp, #-16]!
    adr x0, sn
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_29
    tst x1, #1
    b.eq do_concat_29
do_apply_28:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_30
do_concat_29:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_30:
    str x0, [sp, #-16]!
    adr x0, into
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_32
    tst x1, #1
    b.eq do_concat_32
do_apply_31:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_33
do_concat_32:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_33:
    str x0, [sp, #-16]!
    adr x0, ARM64
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_35
    tst x1, #1
    b.eq do_concat_35
do_apply_34:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_36
do_concat_35:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_36:
    str x0, [sp, #-16]!
    adr x0, Assembly
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_38
    tst x1, #1
    b.eq do_concat_38
do_apply_37:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_39
do_concat_38:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_39:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_41
    tst x1, #1
    b.eq do_concat_41
do_apply_40:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_42
do_concat_41:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_42:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_46
    tst x1, #1
    b.eq do_concat_46
do_apply_45:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_47
do_concat_46:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_47:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_43
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_51
    tst x1, #1
    b.eq do_concat_51
do_apply_50:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_52
do_concat_51:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_52:
    str x0, [sp, #-16]!
    adr x0, is
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_54
    tst x1, #1
    b.eq do_concat_54
do_apply_53:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_55
do_concat_54:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_55:
    str x0, [sp, #-16]!
    adr x0, threaded
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_57
    tst x1, #1
    b.eq do_concat_57
do_apply_56:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_58
do_concat_57:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_58:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Stack
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_60
    tst x1, #1
    b.eq do_concat_60
do_apply_59:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_61
do_concat_60:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_61:
    str x0, [sp, #-16]!
    adr x0, Machine
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_63
    tst x1, #1
    b.eq do_concat_63
do_apply_62:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_64
do_concat_63:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_64:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_48
    adr x0, Context
    str x0, [sp, #-16]!
    adr x0, is
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_68
    tst x1, #1
    b.eq do_concat_68
do_apply_67:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_69
do_concat_68:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_69:
    str x0, [sp, #-16]!
    adr x0, passed
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_71
    tst x1, #1
    b.eq do_concat_71
do_apply_70:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_72
do_concat_71:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_72:
    str x0, [sp, #-16]!
    adr x0, as
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_74
    tst x1, #1
    b.eq do_concat_74
do_apply_73:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_75
do_concat_74:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_75:
    str x0, [sp, #-16]!
    adr x0, arguments
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_77
    tst x1, #1
    b.eq do_concat_77
do_apply_76:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_78
do_concat_77:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_78:
    str x0, [sp, #-16]!
    adr x0, .
    str x0, [sp, #-16]!
    adr x0, Output
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_80
    tst x1, #1
    b.eq do_concat_80
do_apply_79:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_81
do_concat_80:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_81:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_65
    adr x0, List
    str x0, [sp, #-16]!
    adr x0, of
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_83
    tst x1, #1
    b.eq do_concat_83
do_apply_82:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_84
do_concat_83:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_84:
    str x0, [sp, #-16]!
    adr x0, assembly
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_86
    tst x1, #1
    b.eq do_concat_86
do_apply_85:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_87
do_concat_86:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_87:
    str x0, [sp, #-16]!
    adr x0, instruction
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_89
    tst x1, #1
    b.eq do_concat_89
do_apply_88:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_90
do_concat_89:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_90:
    str x0, [sp, #-16]!
    adr x0, strings
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_92
    tst x1, #1
    b.eq do_concat_92
do_apply_91:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_93
do_concat_92:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_93:
    str x0, [sp, #-16]!
    adr x0, .
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_95
    tst x1, #1
    b.eq do_concat_95
do_apply_94:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_96
do_concat_95:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_96:
    b cond_end_66
cond_false_65:
    adr x0, sign_id
cond_end_66:
    b cond_end_49
cond_false_48:
    adr x0, sign_id
cond_end_49:
    b cond_end_44
cond_false_43:
    adr x0, sign_id
cond_end_44:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_100
    tst x1, #1
    b.eq do_concat_100
do_apply_99:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_101
do_concat_100:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_101:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_97
    b after_func_102_103
func_102:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_104_105
func_104:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_106_107
func_106:
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
    b after_func_108_109
func_108:
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
after_func_108_109:
    // Closure for func_108
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
    adr x1, func_108
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_106_107:
    // Closure for func_106
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
    adr x1, func_106
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_104_105:
    // Closure for func_104
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_104
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_102_103:
    // Closure for func_102
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_102
    ldr x0, [sp], #16
    bl _cons
    b cond_end_98
cond_false_97:
    adr x0, sign_id
cond_end_98:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_label_count
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_113
    tst x1, #1
    b.eq do_concat_113
do_apply_112:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_114
do_concat_113:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_114:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_110
    b after_func_115_116
func_115:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_118
    tst x1, #1
    b.eq do_concat_118
do_apply_117:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_119
do_concat_118:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_119:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_115_116:
    // Closure for func_115
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_115
    ldr x0, [sp], #16
    bl _cons
    b cond_end_111
cond_false_110:
    adr x0, sign_id
cond_end_111:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_strings
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_123
    tst x1, #1
    b.eq do_concat_123
do_apply_122:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_124
do_concat_123:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_124:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_120
    b after_func_125_126
func_125:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_128
    tst x1, #1
    b.eq do_concat_128
do_apply_127:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_129
do_concat_128:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_129:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_131
    tst x1, #1
    b.eq do_concat_131
do_apply_130:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_132
do_concat_131:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_132:
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
    b cond_end_121
cond_false_120:
    adr x0, sign_id
cond_end_121:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_env
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_136
    tst x1, #1
    b.eq do_concat_136
do_apply_135:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_137
do_concat_136:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_137:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_133
    b after_func_138_139
func_138:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_141
    tst x1, #1
    b.eq do_concat_141
do_apply_140:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_142
do_concat_141:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_142:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_144
    tst x1, #1
    b.eq do_concat_144
do_apply_143:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_145
do_concat_144:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_145:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_147
    tst x1, #1
    b.eq do_concat_147
do_apply_146:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_148
do_concat_147:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_148:
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
    b cond_end_134
cond_false_133:
    adr x0, sign_id
cond_end_134:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_stack_offset
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_152
    tst x1, #1
    b.eq do_concat_152
do_apply_151:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_153
do_concat_152:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_153:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_149
    b after_func_154_155
func_154:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_157
    tst x1, #1
    b.eq do_concat_157
do_apply_156:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_158
do_concat_157:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_158:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_160
    tst x1, #1
    b.eq do_concat_160
do_apply_159:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_161
do_concat_160:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_161:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_163
    tst x1, #1
    b.eq do_concat_163
do_apply_162:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_164
do_concat_163:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_164:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_166
    tst x1, #1
    b.eq do_concat_166
do_apply_165:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_167
do_concat_166:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_167:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_154_155:
    // Closure for func_154
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_154
    ldr x0, [sp], #16
    bl _cons
    b cond_end_150
cond_false_149:
    adr x0, sign_id
cond_end_150:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, lookup_var
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_171
    tst x1, #1
    b.eq do_concat_171
do_apply_170:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_172
do_concat_171:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_172:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_168
    b after_func_173_174
func_173:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_175_176
func_175:
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
    b.eq cmp_true_180
    adr x0, sign_id
    b cmp_end_181
cmp_true_180:
cmp_end_181:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_178
    mov x0, #0
    b cond_end_179
cond_false_178:
    adr x0, sign_id
cond_end_179:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_177
    b after_func_182_183
func_182:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_188
    tst x1, #1
    b.eq do_concat_188
do_apply_187:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_189
do_concat_188:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_189:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_191
    tst x1, #1
    b.eq do_concat_191
do_apply_190:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_192
do_concat_191:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_192:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_194
    tst x1, #1
    b.eq do_concat_194
do_apply_193:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_195
do_concat_194:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_195:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_185
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_197
    tst x1, #1
    b.eq do_concat_197
do_apply_196:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_198
do_concat_197:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_198:
    b cond_end_186
cond_false_185:
    adr x0, sign_id
cond_end_186:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_184
    adr x0, lookup_var
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_200
    tst x1, #1
    b.eq do_concat_200
do_apply_199:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_201
do_concat_200:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_201:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_206
    tst x1, #1
    b.eq do_concat_206
do_apply_205:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_207
do_concat_206:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_207:
blk_end_184:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_177
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
blk_end_177:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_175_176:
    // Closure for func_175
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_175
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_173_174:
    // Closure for func_173
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_173
    ldr x0, [sp], #16
    bl _cons
    b cond_end_169
cond_false_168:
    adr x0, sign_id
cond_end_169:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_217
    tst x1, #1
    b.eq do_concat_217
do_apply_216:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_218
do_concat_217:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_218:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_214
    b after_func_219_220
func_219:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_221_222
func_221:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_224_225
func_224:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    b after_func_227_228
func_227:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    b after_func_230_231
func_230:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_232_233
func_232:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_235
    tst x1, #1
    b.eq do_concat_235
do_apply_234:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_236
do_concat_235:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_236:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_238
    tst x1, #1
    b.eq do_concat_238
do_apply_237:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_239
do_concat_238:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_239:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_241
    tst x1, #1
    b.eq do_concat_241
do_apply_240:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_242
do_concat_241:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_242:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_244
    tst x1, #1
    b.eq do_concat_244
do_apply_243:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_245
do_concat_244:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_245:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, new_ctx
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_247
    tst x1, #1
    b.eq do_concat_247
do_apply_246:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_248
do_concat_247:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_248:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_229
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_250
    tst x1, #1
    b.eq do_concat_250
do_apply_249:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_251
do_concat_250:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_251:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res_add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_253
    tst x1, #1
    b.eq do_concat_253
do_apply_252:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_254
do_concat_253:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_254:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_256
    tst x1, #1
    b.eq do_concat_256
do_apply_255:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_257
do_concat_256:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_257:
blk_end_229:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_259
    tst x1, #1
    b.eq do_concat_259
do_apply_258:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_260
do_concat_259:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_260:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_226
    adr x0, add_string
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_262
    tst x1, #1
    b.eq do_concat_262
do_apply_261:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_263
do_concat_262:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_263:
    str x0, [sp, #-16]!
    adr x0, content
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_265
    tst x1, #1
    b.eq do_concat_265
do_apply_264:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_266
do_concat_265:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_266:
blk_end_226:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_268
    tst x1, #1
    b.eq do_concat_268
do_apply_267:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_269
do_concat_268:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_269:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_223
    adr x0, tok_val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_271
    tst x1, #1
    b.eq do_concat_271
do_apply_270:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_272
do_concat_271:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_272:
blk_end_223:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_221_222:
    // Closure for func_221
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_221
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_219_220:
    // Closure for func_219
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_219
    ldr x0, [sp], #16
    bl _cons
    b cond_end_215
cond_false_214:
    adr x0, sign_id
cond_end_215:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_apply
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_273
    b after_func_278_279
func_278:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_280_281
func_280:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_284
    tst x1, #1
    b.eq do_concat_284
do_apply_283:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_285
do_concat_284:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_285:
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_290
    tst x1, #1
    b.eq do_concat_290
do_apply_289:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_291
do_concat_290:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_291:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_296
    tst x1, #1
    b.eq do_concat_296
do_apply_295:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_297
do_concat_296:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_297:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, is_spread_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_299
    tst x1, #1
    b.eq do_concat_299
do_apply_298:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_300
do_concat_299:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_300:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_2
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_301
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_306
    tst x1, #1
    b.eq do_concat_306
do_apply_305:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_307
do_concat_306:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_307:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_309
    tst x1, #1
    b.eq do_concat_309
do_apply_308:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_310
do_concat_309:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_310:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_301
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_312
    tst x1, #1
    b.eq do_concat_312
do_apply_311:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_313
do_concat_312:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_313:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_315
    tst x1, #1
    b.eq do_concat_315
do_apply_314:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_316
do_concat_315:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_316:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_301
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_318
    tst x1, #1
    b.eq do_concat_318
do_apply_317:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_319
do_concat_318:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_319:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_301
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_321
    tst x1, #1
    b.eq do_concat_321
do_apply_320:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_322
do_concat_321:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_322:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_301
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-160]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_301
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_330
    tst x1, #1
    b.eq do_concat_330
do_apply_329:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_331
do_concat_330:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_331:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_301
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-176]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_333
    tst x1, #1
    b.eq do_concat_333
do_apply_332:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_334
do_concat_333:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_334:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_301
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
    b.ne blk_end_335
    adr x0, str_6
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_335:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_337
    tst x1, #1
    b.eq do_concat_337
do_apply_336:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_338
do_concat_337:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_338:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_340
    tst x1, #1
    b.eq do_concat_340
do_apply_339:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_341
do_concat_340:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_341:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_343
    tst x1, #1
    b.eq do_concat_343
do_apply_342:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_344
do_concat_343:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_344:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_346
    tst x1, #1
    b.eq do_concat_346
do_apply_345:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_347
do_concat_346:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_347:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-208]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_301:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_349
    tst x1, #1
    b.eq do_concat_349
do_apply_348:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_350
do_concat_349:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_350:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, str_7
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_352
    tst x1, #1
    b.eq do_concat_352
do_apply_351:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_353
do_concat_352:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_353:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_355
    tst x1, #1
    b.eq do_concat_355
do_apply_354:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_356
do_concat_355:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_356:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_358
    tst x1, #1
    b.eq do_concat_358
do_apply_357:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_359
do_concat_358:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_359:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-240]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_361
    tst x1, #1
    b.eq do_concat_361
do_apply_360:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_362
do_concat_361:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_362:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_364
    tst x1, #1
    b.eq do_concat_364
do_apply_363:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_365
do_concat_364:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_365:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-272]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_367
    tst x1, #1
    b.eq do_concat_367
do_apply_366:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_368
do_concat_367:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_368:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-288]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_370
    tst x1, #1
    b.eq do_concat_370
do_apply_369:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_371
do_concat_370:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_371:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-288]
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-320]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_376
    tst x1, #1
    b.eq do_concat_376
do_apply_375:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_377
do_concat_376:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_377:
    str x0, [sp, #-16]!
    adr x0, str_8
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_379
    tst x1, #1
    b.eq do_concat_379
do_apply_378:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_380
do_concat_379:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_380:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-336]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_382
    tst x1, #1
    b.eq do_concat_382
do_apply_381:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_383
do_concat_382:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_383:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-336]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_385
    tst x1, #1
    b.eq do_concat_385
do_apply_384:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_386
do_concat_385:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_386:
    str x0, [sp, #-16]!
    adr x0, str_9
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
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-368]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_391
    tst x1, #1
    b.eq do_concat_391
do_apply_390:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_392
do_concat_391:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_392:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_282
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
    b.ne blk_end_393
    adr x0, str_12
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_13
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_395
    tst x1, #1
    b.eq do_concat_395
do_apply_394:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_396
do_concat_395:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_396:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-352]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_398
    tst x1, #1
    b.eq do_concat_398
do_apply_397:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_399
do_concat_398:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_399:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_401
    tst x1, #1
    b.eq do_concat_401
do_apply_400:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_402
do_concat_401:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_402:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_404
    tst x1, #1
    b.eq do_concat_404
do_apply_403:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_405
do_concat_404:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_405:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_14
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_15
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_407
    tst x1, #1
    b.eq do_concat_407
do_apply_406:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_408
do_concat_407:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_408:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-352]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_410
    tst x1, #1
    b.eq do_concat_410
do_apply_409:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_411
do_concat_410:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_411:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_413
    tst x1, #1
    b.eq do_concat_413
do_apply_412:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_414
do_concat_413:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_414:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_416
    tst x1, #1
    b.eq do_concat_416
do_apply_415:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_417
do_concat_416:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_417:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_16
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_17
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_18
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_19
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_20
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_419
    tst x1, #1
    b.eq do_concat_419
do_apply_418:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_420
do_concat_419:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_420:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-384]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_422
    tst x1, #1
    b.eq do_concat_422
do_apply_421:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_423
do_concat_422:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_423:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_425
    tst x1, #1
    b.eq do_concat_425
do_apply_424:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_426
do_concat_425:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_426:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_428
    tst x1, #1
    b.eq do_concat_428
do_apply_427:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_429
do_concat_428:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_429:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-352]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_431
    tst x1, #1
    b.eq do_concat_431
do_apply_430:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_432
do_concat_431:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_432:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_434
    tst x1, #1
    b.eq do_concat_434
do_apply_433:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_435
do_concat_434:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_435:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_22
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_23
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_24
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, str_6
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_393
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-384]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_437
    tst x1, #1
    b.eq do_concat_437
do_apply_436:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_438
do_concat_437:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_438:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_440
    tst x1, #1
    b.eq do_concat_440
do_apply_439:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_441
do_concat_440:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_441:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_393:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_443
    tst x1, #1
    b.eq do_concat_443
do_apply_442:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_444
do_concat_443:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_444:
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
    str x0, [sp, #-16]!
    ldr x0, [x29, #-368]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_282:
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
    b cond_end_274
cond_false_273:
    adr x0, sign_id
cond_end_274:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_spread_node
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_457
    tst x1, #1
    b.eq do_concat_457
do_apply_456:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_458
do_concat_457:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_458:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_454
    b after_func_459_460
func_459:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_466
    tst x1, #1
    b.eq do_concat_466
do_apply_465:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_467
do_concat_466:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_467:
    str x0, [sp, #-16]!
    adr x0, ast_postfix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_463
    adr x0, sign_id
    b cmp_end_464
cmp_true_463:
cmp_end_464:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_461
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_469
    tst x1, #1
    b.eq do_concat_469
do_apply_468:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_470
do_concat_469:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_470:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_472
    tst x1, #1
    b.eq do_concat_472
do_apply_471:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_473
do_concat_472:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_473:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_475
    tst x1, #1
    b.eq do_concat_475
do_apply_474:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_476
do_concat_475:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_476:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_478
    tst x1, #1
    b.eq do_concat_478
do_apply_477:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_479
do_concat_478:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_479:
    str x0, [sp, #-16]!
    mov x0, #126
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_481
    tst x1, #1
    b.eq do_concat_481
do_apply_480:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_482
do_concat_481:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_482:
    b and_end_462
and_fail_461:
    adr x0, sign_id
and_end_462:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_459_460:
    // Closure for func_459
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_459
    ldr x0, [sp], #16
    bl _cons
    b cond_end_455
cond_false_454:
    adr x0, sign_id
cond_end_455:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, push_var
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_486
    tst x1, #1
    b.eq do_concat_486
do_apply_485:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_487
do_concat_486:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_487:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_483
    b after_func_488_489
func_488:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    b after_func_493_494
func_493:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_493_494:
    // Closure for func_493
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_493
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, ctx_label_count
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_495
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_495
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, offset
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_495
    adr x0, offset
blk_end_495:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_506
    tst x1, #1
    b.eq do_concat_506
do_apply_505:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_507
do_concat_506:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_507:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_509
    tst x1, #1
    b.eq do_concat_509
do_apply_508:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_510
do_concat_509:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_510:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_492
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_512
    tst x1, #1
    b.eq do_concat_512
do_apply_511:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_513
do_concat_512:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_513:
    str x0, [sp, #-16]!
    mov x0, #8
    ldr x1, [sp], #16
    sub x0, x1, x0
blk_end_492:
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_488_489:
    // Closure for func_488
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_488
    ldr x0, [sp], #16
    bl _cons
    b cond_end_484
cond_false_483:
    adr x0, sign_id
cond_end_484:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, add_string
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_517
    tst x1, #1
    b.eq do_concat_517
do_apply_516:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_518
do_concat_517:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_518:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_514
    b after_func_519_520
func_519:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_521_522
func_521:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, str_25
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_523
    b after_func_524_525
func_524:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    b after_func_527_528
func_527:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    adr x0, label
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, count
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    adr x0, label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
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
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_534
    tst x1, #1
    b.eq do_concat_534
do_apply_533:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_535
do_concat_534:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_535:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_529
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_537
    tst x1, #1
    b.eq do_concat_537
do_apply_536:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_538
do_concat_537:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_538:
blk_end_529:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_540
    tst x1, #1
    b.eq do_concat_540
do_apply_539:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_541
do_concat_540:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_541:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_543
    tst x1, #1
    b.eq do_concat_543
do_apply_542:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_544
do_concat_543:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_544:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_526
    adr x0, make_label
    str x0, [sp, #-16]!
    adr x0, str_26
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_546
    tst x1, #1
    b.eq do_concat_546
do_apply_545:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_547
do_concat_546:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_547:
    str x0, [sp, #-16]!
    adr x0, count
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_549
    tst x1, #1
    b.eq do_concat_549
do_apply_548:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_550
do_concat_549:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_550:
blk_end_526:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_552
    tst x1, #1
    b.eq do_concat_552
do_apply_551:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_553
do_concat_552:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_553:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_523
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_555
    tst x1, #1
    b.eq do_concat_555
do_apply_554:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_556
do_concat_555:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_556:
blk_end_523:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_521_522:
    // Closure for func_521
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_521
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_515
cond_false_514:
    adr x0, sign_id
cond_end_515:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strlen
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_560
    tst x1, #1
    b.eq do_concat_560
do_apply_559:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_561
do_concat_560:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_561:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_557
    b after_func_562_563
func_562:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_565_566
func_565:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_565_566:
    // Closure for func_565
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_565
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_570
    adr x0, sign_id
    b cmp_end_571
cmp_true_570:
cmp_end_571:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_568
    mov x0, #0
    b cond_end_569
cond_false_568:
    adr x0, sign_id
cond_end_569:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_567
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, strlen
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_573
    tst x1, #1
    b.eq do_concat_573
do_apply_572:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_574
do_concat_573:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_574:
blk_end_567:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_576
    tst x1, #1
    b.eq do_concat_576
do_apply_575:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_577
do_concat_576:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_577:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_564
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_564:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_562_563:
    // Closure for func_562
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_562
    ldr x0, [sp], #16
    bl _cons
    b cond_end_558
cond_false_557:
    adr x0, sign_id
cond_end_558:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strcpy
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_581
    tst x1, #1
    b.eq do_concat_581
do_apply_580:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_582
do_concat_581:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_582:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_578
    b after_func_583_584
func_583:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_585_586
func_585:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_588_589
func_588:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_588_589:
    // Closure for func_588
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_588
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, c
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_593
    adr x0, sign_id
    b cmp_end_594
cmp_true_593:
cmp_end_594:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_591
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_595
    ldr x0, [x29, #-48]
blk_end_595:
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
    b cond_end_592
cond_false_591:
    adr x0, sign_id
cond_end_592:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_590
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, c
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_590
    adr x0, strcpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_600
    tst x1, #1
    b.eq do_concat_600
do_apply_599:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_601
do_concat_600:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_601:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
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
blk_end_590:
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
    b.ne blk_end_587
    ldr x0, [x29, #-32]
    ldr x0, [x0] // @ load
blk_end_587:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_585_586:
    // Closure for func_585
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_585
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_583_584:
    // Closure for func_583
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_583
    ldr x0, [sp], #16
    bl _cons
    b cond_end_579
cond_false_578:
    adr x0, sign_id
cond_end_579:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, strcat
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_611
    tst x1, #1
    b.eq do_concat_611
do_apply_610:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_612
do_concat_611:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_612:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_608
    b after_func_613_614
func_613:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
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
    b after_func_618_619
func_618:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x0, strcpy
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    str x0, [sp, #-16]!
    adr x0, len
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_622
    tst x1, #1
    b.eq do_concat_622
do_apply_621:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_623
do_concat_622:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_623:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_625
    tst x1, #1
    b.eq do_concat_625
do_apply_624:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_626
do_concat_625:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_626:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_620
    ldr x0, [x29, #-48]
blk_end_620:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_628
    tst x1, #1
    b.eq do_concat_628
do_apply_627:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_629
do_concat_628:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_629:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_617
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_631
    tst x1, #1
    b.eq do_concat_631
do_apply_630:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_632
do_concat_631:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_632:
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
    adr x1, func_613
    ldr x0, [sp], #16
    bl _cons
    b cond_end_609
cond_false_608:
    adr x0, sign_id
cond_end_609:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_636
    tst x1, #1
    b.eq do_concat_636
do_apply_635:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_637
do_concat_636:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_637:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_633
    b after_func_638_639
func_638:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_640_641
func_640:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_643_644
func_643:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    b after_func_646_647
func_646:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_646_647:
    // Closure for func_646
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_646
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_649_650
func_649:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x0, strcpy
    str x0, [sp, #-16]!
    adr x0, new_s
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_653
    tst x1, #1
    b.eq do_concat_653
do_apply_652:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_654
do_concat_653:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_654:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_656
    tst x1, #1
    b.eq do_concat_656
do_apply_655:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_657
do_concat_656:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_657:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_651
    adr x0, strcpy
    str x0, [sp, #-16]!
    adr x0, new_s
    str x0, [sp, #-16]!
    adr x0, len1
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_659
    tst x1, #1
    b.eq do_concat_659
do_apply_658:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_660
do_concat_659:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_660:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_662
    tst x1, #1
    b.eq do_concat_662
do_apply_661:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_663
do_concat_662:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_663:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_651
    adr x0, new_s
blk_end_651:
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
    b.ne blk_end_648
    adr x0, alloc
    str x0, [sp, #-16]!
    adr x0, len1
    str x0, [sp, #-16]!
    adr x0, len2
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
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
blk_end_648:
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
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_645
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_674
    tst x1, #1
    b.eq do_concat_674
do_apply_673:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_675
do_concat_674:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_675:
blk_end_645:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_677
    tst x1, #1
    b.eq do_concat_677
do_apply_676:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_678
do_concat_677:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_678:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_642
    adr x0, strlen
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_680
    tst x1, #1
    b.eq do_concat_680
do_apply_679:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_681
do_concat_680:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_681:
blk_end_642:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_640_641:
    // Closure for func_640
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_640
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_634
cond_false_633:
    adr x0, sign_id
cond_end_634:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, concat_list
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
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_682
    b after_func_687_688
func_687:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_692
    adr x0, sign_id
    b cmp_end_693
cmp_true_692:
cmp_end_693:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_690
    adr x0, str_27
    b cond_end_691
cond_false_690:
    adr x0, sign_id
cond_end_691:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_689
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_695
    tst x1, #1
    b.eq do_concat_695
do_apply_694:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_696
do_concat_695:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_696:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_698
    tst x1, #1
    b.eq do_concat_698
do_apply_697:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_699
do_concat_698:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_699:
    str x0, [sp, #-16]!
    adr x0, concat_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_701
    tst x1, #1
    b.eq do_concat_701
do_apply_700:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_702
do_concat_701:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_702:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_704
    tst x1, #1
    b.eq do_concat_704
do_apply_703:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_705
do_concat_704:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_705:
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
blk_end_689:
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
    b cond_end_683
cond_false_682:
    adr x0, sign_id
cond_end_683:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, int_to_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_712
    tst x1, #1
    b.eq do_concat_712
do_apply_711:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_713
do_concat_712:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_713:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_709
    b after_func_714_715
func_714:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_719
    adr x0, sign_id
    b cmp_end_720
cmp_true_719:
cmp_end_720:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_717
    mov x0, #48
    b cond_end_718
cond_false_717:
    adr x0, sign_id
cond_end_718:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_716
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_723
    adr x0, sign_id
    b cmp_end_724
cmp_true_723:
cmp_end_724:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_721
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_726
    tst x1, #1
    b.eq do_concat_726
do_apply_725:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_727
do_concat_726:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_727:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    mov x0, #0
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    sub x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_729
    tst x1, #1
    b.eq do_concat_729
do_apply_728:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_730
do_concat_729:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_730:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_732
    tst x1, #1
    b.eq do_concat_732
do_apply_731:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_733
do_concat_732:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_733:
    b cond_end_722
cond_false_721:
    adr x0, sign_id
cond_end_722:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_716
    adr x0, _int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
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
blk_end_716:
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
    b cond_end_710
cond_false_709:
    adr x0, sign_id
cond_end_710:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, _int_to_str_rec
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_740
    tst x1, #1
    b.eq do_concat_740
do_apply_739:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_741
do_concat_740:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_741:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_737
    b after_func_742_743
func_742:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_747
    adr x0, sign_id
    b cmp_end_748
cmp_true_747:
cmp_end_748:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_745
    adr x0, str_27
    b cond_end_746
cond_false_745:
    adr x0, sign_id
cond_end_746:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_744
    b after_func_749_750
func_749:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, _int_to_str_rec
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x0, x1, x0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_752
    tst x1, #1
    b.eq do_concat_752
do_apply_751:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_753
do_concat_752:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_753:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_755
    tst x1, #1
    b.eq do_concat_755
do_apply_754:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_756
do_concat_755:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_756:
    str x0, [sp, #-16]!
    adr x0, char_to_str
    str x0, [sp, #-16]!
    adr x0, digit
    str x0, [sp, #-16]!
    mov x0, #48
    ldr x1, [sp], #16
    bl _add
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_758
    tst x1, #1
    b.eq do_concat_758
do_apply_757:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_759
do_concat_758:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_759:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_761
    tst x1, #1
    b.eq do_concat_761
do_apply_760:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_762
do_concat_761:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_762:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_764
    tst x1, #1
    b.eq do_concat_764
do_apply_763:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_765
do_concat_764:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_765:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_744
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #10
    ldr x1, [sp], #16
    sdiv x2, x1, x0
    msub x0, x2, x0, x1
blk_end_744:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_742_743:
    // Closure for func_742
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_742
    ldr x0, [sp], #16
    bl _cons
    b cond_end_738
cond_false_737:
    adr x0, sign_id
cond_end_738:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, char_to_str
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_769
    tst x1, #1
    b.eq do_concat_769
do_apply_768:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_770
do_concat_769:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_770:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_766
    b after_func_771_772
func_771:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_774_775
func_774:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    adr x0, s
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_776
    adr x0, s
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    str x0, [x1]
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_776
    adr x0, s
blk_end_776:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_778
    tst x1, #1
    b.eq do_concat_778
do_apply_777:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_779
do_concat_778:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_779:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_773
    adr x0, alloc
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_781
    tst x1, #1
    b.eq do_concat_781
do_apply_780:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_782
do_concat_781:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_782:
blk_end_773:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_771_772:
    // Closure for func_771
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_771
    ldr x0, [sp], #16
    bl _cons
    b cond_end_767
cond_false_766:
    adr x0, sign_id
cond_end_767:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, emit_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_786
    tst x1, #1
    b.eq do_concat_786
do_apply_785:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_787
do_concat_786:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_787:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_783
    b after_func_788_789
func_788:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_790_791
func_790:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_793
    tst x1, #1
    b.eq do_concat_793
do_apply_792:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_794
do_concat_793:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_794:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_796
    tst x1, #1
    b.eq do_concat_796
do_apply_795:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_797
do_concat_796:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_797:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_799
    tst x1, #1
    b.eq do_concat_799
do_apply_798:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_800
do_concat_799:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_800:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_790_791:
    // Closure for func_790
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_790
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_784
cond_false_783:
    adr x0, sign_id
cond_end_784:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, make_label
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_804
    tst x1, #1
    b.eq do_concat_804
do_apply_803:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_805
do_concat_804:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_805:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_801
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
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_811
    tst x1, #1
    b.eq do_concat_811
do_apply_810:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_812
do_concat_811:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_812:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #95
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_814
    tst x1, #1
    b.eq do_concat_814
do_apply_813:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_815
do_concat_814:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_815:
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_817
    tst x1, #1
    b.eq do_concat_817
do_apply_816:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_818
do_concat_817:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_818:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_820
    tst x1, #1
    b.eq do_concat_820
do_apply_819:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_821
do_concat_820:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_821:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_823
    tst x1, #1
    b.eq do_concat_823
do_apply_822:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_824
do_concat_823:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_824:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_808_809:
    // Closure for func_808
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
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
    b cond_end_802
cond_false_801:
    adr x0, sign_id
cond_end_802:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, new_label
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_828
    tst x1, #1
    b.eq do_concat_828
do_apply_827:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_829
do_concat_828:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_829:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_825
    b after_func_830_831
func_830:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_832_833
func_832:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_835_836
func_835:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    str x0, [sp, #-16]!
    b after_func_838_839
func_838:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_838_839:
    // Closure for func_838
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_838
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, lbl
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    adr x0, count
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _add
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_840
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_842
    tst x1, #1
    b.eq do_concat_842
do_apply_841:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_843
do_concat_842:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_843:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_840
    adr x0, ctx_env
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_845
    tst x1, #1
    b.eq do_concat_845
do_apply_844:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_846
do_concat_845:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_846:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_840
    adr x0, ctx_stack_offset
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_848
    tst x1, #1
    b.eq do_concat_848
do_apply_847:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_849
do_concat_848:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_849:
blk_end_840:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_851
    tst x1, #1
    b.eq do_concat_851
do_apply_850:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_852
do_concat_851:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_852:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_854
    tst x1, #1
    b.eq do_concat_854
do_apply_853:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_855
do_concat_854:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_855:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_837
    adr x0, make_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_857
    tst x1, #1
    b.eq do_concat_857
do_apply_856:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_858
do_concat_857:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_858:
    str x0, [sp, #-16]!
    adr x0, count
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_860
    tst x1, #1
    b.eq do_concat_860
do_apply_859:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_861
do_concat_860:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_861:
blk_end_837:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_863
    tst x1, #1
    b.eq do_concat_863
do_apply_862:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_864
do_concat_863:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_864:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_834
    adr x0, ctx_label_count
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_866
    tst x1, #1
    b.eq do_concat_866
do_apply_865:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_867
do_concat_866:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_867:
blk_end_834:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_832_833:
    // Closure for func_832
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_832
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_830_831:
    // Closure for func_830
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_830
    ldr x0, [sp], #16
    bl _cons
    b cond_end_826
cond_false_825:
    adr x0, sign_id
cond_end_826:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, format_str_list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_871
    tst x1, #1
    b.eq do_concat_871
do_apply_870:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_872
do_concat_871:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_872:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_868
    b after_func_873_874
func_873:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_878
    adr x0, sign_id
    b cmp_end_879
cmp_true_878:
cmp_end_879:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_876
    adr x0, str_28
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    b cond_end_877
cond_false_876:
    adr x0, sign_id
cond_end_877:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_875
    b after_func_880_881
func_880:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_880_881:
    // Closure for func_880
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_880
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_883_884
func_883:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_885_886
func_885:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_885_886:
    // Closure for func_885
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_885
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    adr x0, label
    str x0, [sp, #-16]!
    adr x0, str_29
    str x0, [sp, #-16]!
    adr x0, content
    str x0, [sp, #-16]!
    adr x0, str_30
    str x0, [sp, #-16]!
    adr x0, format_str_list
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_888
    tst x1, #1
    b.eq do_concat_888
do_apply_887:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_889
do_concat_888:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_889:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_891
    tst x1, #1
    b.eq do_concat_891
do_apply_890:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_892
do_concat_891:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_892:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_894
    tst x1, #1
    b.eq do_concat_894
do_apply_893:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_895
do_concat_894:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_895:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_882
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_897
    tst x1, #1
    b.eq do_concat_897
do_apply_896:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_898
do_concat_897:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_898:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_900
    tst x1, #1
    b.eq do_concat_900
do_apply_899:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_901
do_concat_900:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_901:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, entry
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_903
    tst x1, #1
    b.eq do_concat_903
do_apply_902:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_904
do_concat_903:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_904:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_906
    tst x1, #1
    b.eq do_concat_906
do_apply_905:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_907
do_concat_906:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_907:
blk_end_882:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_909
    tst x1, #1
    b.eq do_concat_909
do_apply_908:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_910
do_concat_909:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_910:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_875
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_912
    tst x1, #1
    b.eq do_concat_912
do_apply_911:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_913
do_concat_912:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_913:
blk_end_875:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_873_874:
    // Closure for func_873
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_873
    ldr x0, [sp], #16
    bl _cons
    b cond_end_869
cond_false_868:
    adr x0, sign_id
cond_end_869:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_program
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_917
    tst x1, #1
    b.eq do_concat_917
do_apply_916:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_918
do_concat_917:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_918:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_914
    b after_func_919_920
func_919:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_922_923
func_922:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_922_923:
    // Closure for func_922
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_922
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_925_926
func_925:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_927_928
func_927:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_927_928:
    // Closure for func_927
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_927
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_925_926:
    // Closure for func_925
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_925
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat_list
    str x0, [sp, #-16]!
    adr x0, asm_list
    str x0, [sp, #-16]!
    adr x0, str_31
    str x0, [sp, #-16]!
    adr x0, format_str_list
    str x0, [sp, #-16]!
    adr x0, str_list
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_932
    tst x1, #1
    b.eq do_concat_932
do_apply_931:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_933
do_concat_932:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_933:
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _concat
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_935
    tst x1, #1
    b.eq do_concat_935
do_apply_934:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_936
do_concat_935:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_936:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_938
    tst x1, #1
    b.eq do_concat_938
do_apply_937:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_939
do_concat_938:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_939:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_924
    adr x0, ctx_strings
    str x0, [sp, #-16]!
    adr x0, ctx
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_941
    tst x1, #1
    b.eq do_concat_941
do_apply_940:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_942
do_concat_941:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_942:
    str x0, [sp, #-16]!
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_944
    tst x1, #1
    b.eq do_concat_944
do_apply_943:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_945
do_concat_944:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_945:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_947
    tst x1, #1
    b.eq do_concat_947
do_apply_946:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_948
do_concat_947:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_948:
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_950
    tst x1, #1
    b.eq do_concat_950
do_apply_949:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_951
do_concat_950:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_951:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_953
    tst x1, #1
    b.eq do_concat_953
do_apply_952:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_954
do_concat_953:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_954:
blk_end_924:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_956
    tst x1, #1
    b.eq do_concat_956
do_apply_955:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_957
do_concat_956:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_957:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_921
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_959
    tst x1, #1
    b.eq do_concat_959
do_apply_958:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_960
do_concat_959:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_960:
    str x0, [sp, #-16]!
    adr x0, make_context
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_962
    tst x1, #1
    b.eq do_concat_962
do_apply_961:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_963
do_concat_962:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_963:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_965
    tst x1, #1
    b.eq do_concat_965
do_apply_964:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_966
do_concat_965:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_966:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_968
    tst x1, #1
    b.eq do_concat_968
do_apply_967:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_969
do_concat_968:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_969:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_971
    tst x1, #1
    b.eq do_concat_971
do_apply_970:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_972
do_concat_971:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_972:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_974
    tst x1, #1
    b.eq do_concat_974
do_apply_973:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_975
do_concat_974:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_975:
blk_end_921:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_919_920:
    // Closure for func_919
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_919
    ldr x0, [sp], #16
    bl _cons
    b cond_end_915
cond_false_914:
    adr x0, sign_id
cond_end_915:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_node
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_979
    tst x1, #1
    b.eq do_concat_979
do_apply_978:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_980
do_concat_979:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_980:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_976
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
    b after_func_986_987
func_986:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_986_987:
    // Closure for func_986
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_986
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
    b.eq cmp_true_991
    adr x0, sign_id
    b cmp_end_992
cmp_true_991:
cmp_end_992:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_989
    adr x0, compile_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_994
    tst x1, #1
    b.eq do_concat_994
do_apply_993:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_995
do_concat_994:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_995:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_997
    tst x1, #1
    b.eq do_concat_997
do_apply_996:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_998
do_concat_997:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_998:
    b cond_end_990
cond_false_989:
    adr x0, sign_id
cond_end_990:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_infix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1001
    adr x0, sign_id
    b cmp_end_1002
cmp_true_1001:
cmp_end_1002:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_999
    adr x0, compile_infix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1004
    tst x1, #1
    b.eq do_concat_1004
do_apply_1003:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1005
do_concat_1004:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1005:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1007
    tst x1, #1
    b.eq do_concat_1007
do_apply_1006:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1008
do_concat_1007:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1008:
    b cond_end_1000
cond_false_999:
    adr x0, sign_id
cond_end_1000:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_prefix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1011
    adr x0, sign_id
    b cmp_end_1012
cmp_true_1011:
cmp_end_1012:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1009
    adr x0, compile_prefix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1014
    tst x1, #1
    b.eq do_concat_1014
do_apply_1013:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1015
do_concat_1014:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1015:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1017
    tst x1, #1
    b.eq do_concat_1017
do_apply_1016:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1018
do_concat_1017:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1018:
    b cond_end_1010
cond_false_1009:
    adr x0, sign_id
cond_end_1010:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_postfix
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1021
    adr x0, sign_id
    b cmp_end_1022
cmp_true_1021:
cmp_end_1022:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1019
    adr x0, compile_postfix
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1024
    tst x1, #1
    b.eq do_concat_1024
do_apply_1023:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1025
do_concat_1024:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1025:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1027
    tst x1, #1
    b.eq do_concat_1027
do_apply_1026:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1028
do_concat_1027:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1028:
    b cond_end_1020
cond_false_1019:
    adr x0, sign_id
cond_end_1020:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_block
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1031
    adr x0, sign_id
    b cmp_end_1032
cmp_true_1031:
cmp_end_1032:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1029
    adr x0, compile_block
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1034
    tst x1, #1
    b.eq do_concat_1034
do_apply_1033:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1035
do_concat_1034:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1035:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1037
    tst x1, #1
    b.eq do_concat_1037
do_apply_1036:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1038
do_concat_1037:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1038:
    b cond_end_1030
cond_false_1029:
    adr x0, sign_id
cond_end_1030:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_unit
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1041
    adr x0, sign_id
    b cmp_end_1042
cmp_true_1041:
cmp_end_1042:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1039
    adr x0, compile_unit
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1044
    tst x1, #1
    b.eq do_concat_1044
do_apply_1043:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1045
do_concat_1044:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1045:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1047
    tst x1, #1
    b.eq do_concat_1047
do_apply_1046:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1048
do_concat_1047:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1048:
    b cond_end_1040
cond_false_1039:
    adr x0, sign_id
cond_end_1040:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1051
    adr x0, sign_id
    b cmp_end_1052
cmp_true_1051:
cmp_end_1052:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1049
    adr x0, compile_str
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1054
    tst x1, #1
    b.eq do_concat_1054
do_apply_1053:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1055
do_concat_1054:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1055:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1057
    tst x1, #1
    b.eq do_concat_1057
do_apply_1056:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1058
do_concat_1057:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1058:
    b cond_end_1050
cond_false_1049:
    adr x0, sign_id
cond_end_1050:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_id
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1061
    adr x0, sign_id
    b cmp_end_1062
cmp_true_1061:
cmp_end_1062:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1059
    adr x0, compile_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1064
    tst x1, #1
    b.eq do_concat_1064
do_apply_1063:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1065
do_concat_1064:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1065:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1067
    tst x1, #1
    b.eq do_concat_1067
do_apply_1066:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1068
do_concat_1067:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1068:
    b cond_end_1060
cond_false_1059:
    adr x0, sign_id
cond_end_1060:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, type
    str x0, [sp, #-16]!
    adr x0, ast_apply
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1071
    adr x0, sign_id
    b cmp_end_1072
cmp_true_1071:
cmp_end_1072:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1069
    adr x0, compile_apply
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1074
    tst x1, #1
    b.eq do_concat_1074
do_apply_1073:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1075
do_concat_1074:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1075:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1077
    tst x1, #1
    b.eq do_concat_1077
do_apply_1076:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1078
do_concat_1077:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1078:
    b cond_end_1070
cond_false_1069:
    adr x0, sign_id
cond_end_1070:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, str_32
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_988
    adr x0, str_33
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
blk_end_988:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1080
    tst x1, #1
    b.eq do_concat_1080
do_apply_1079:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1081
do_concat_1080:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1081:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_985
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1083
    tst x1, #1
    b.eq do_concat_1083
do_apply_1082:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1084
do_concat_1083:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1084:
blk_end_985:
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
    b cond_end_977
cond_false_976:
    adr x0, sign_id
cond_end_977:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1088
    tst x1, #1
    b.eq do_concat_1088
do_apply_1087:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1089
do_concat_1088:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1089:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1085
    b after_func_1090_1091
func_1090:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1092_1093
func_1092:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1095_1096
func_1095:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1095_1096:
    // Closure for func_1095
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1095
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_34
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1098
    tst x1, #1
    b.eq do_concat_1098
do_apply_1097:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1099
do_concat_1098:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1099:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, int_to_str
    str x0, [sp, #-16]!
    adr x0, val
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1101
    tst x1, #1
    b.eq do_concat_1101
do_apply_1100:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1102
do_concat_1101:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1102:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1104
    tst x1, #1
    b.eq do_concat_1104
do_apply_1103:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1105
do_concat_1104:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1105:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1107
    tst x1, #1
    b.eq do_concat_1107
do_apply_1106:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1108
do_concat_1107:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1108:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1110
    tst x1, #1
    b.eq do_concat_1110
do_apply_1109:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1111
do_concat_1110:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1111:
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1113
    tst x1, #1
    b.eq do_concat_1113
do_apply_1112:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1114
do_concat_1113:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1114:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1094
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1116
    tst x1, #1
    b.eq do_concat_1116
do_apply_1115:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1117
do_concat_1116:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1117:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1119
    tst x1, #1
    b.eq do_concat_1119
do_apply_1118:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1120
do_concat_1119:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1120:
blk_end_1094:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1092_1093:
    // Closure for func_1092
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1092
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1090_1091:
    // Closure for func_1090
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1090
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1086
cond_false_1085:
    adr x0, sign_id
cond_end_1086:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_unit
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1124
    tst x1, #1
    b.eq do_concat_1124
do_apply_1123:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1125
do_concat_1124:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1125:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1121
    b after_func_1126_1127
func_1126:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1128_1129
func_1128:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_35
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
after_func_1128_1129:
    // Closure for func_1128
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1128
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1122
cond_false_1121:
    adr x0, sign_id
cond_end_1122:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_prefix
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1133
    tst x1, #1
    b.eq do_concat_1133
do_apply_1132:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1134
do_concat_1133:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1134:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1130
    b after_func_1135_1136
func_1135:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1137_1138
func_1137:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1140_1141
func_1140:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1142_1143
func_1142:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
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
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1140_1141:
    // Closure for func_1140
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1140
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1148
    tst x1, #1
    b.eq do_concat_1148
do_apply_1147:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1149
do_concat_1148:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1149:
    str x0, [sp, #-16]!
    mov x0, #64
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1151
    tst x1, #1
    b.eq do_concat_1151
do_apply_1150:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1152
do_concat_1151:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1152:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1145
    adr x0, compile_prefix_at
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1154
    tst x1, #1
    b.eq do_concat_1154
do_apply_1153:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1155
do_concat_1154:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1155:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1157
    tst x1, #1
    b.eq do_concat_1157
do_apply_1156:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1158
do_concat_1157:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1158:
    b cond_end_1146
cond_false_1145:
    adr x0, sign_id
cond_end_1146:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1162
    tst x1, #1
    b.eq do_concat_1162
do_apply_1161:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1163
do_concat_1162:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1163:
    str x0, [sp, #-16]!
    mov x0, #33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1165
    tst x1, #1
    b.eq do_concat_1165
do_apply_1164:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1166
do_concat_1165:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1166:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1159
    adr x0, compile_prefix_not
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1168
    tst x1, #1
    b.eq do_concat_1168
do_apply_1167:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1169
do_concat_1168:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1169:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1171
    tst x1, #1
    b.eq do_concat_1171
do_apply_1170:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1172
do_concat_1171:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1172:
    b cond_end_1160
cond_false_1159:
    adr x0, sign_id
cond_end_1160:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1176
    tst x1, #1
    b.eq do_concat_1176
do_apply_1175:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1177
do_concat_1176:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1177:
    str x0, [sp, #-16]!
    adr x0, str_36
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1179
    tst x1, #1
    b.eq do_concat_1179
do_apply_1178:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1180
do_concat_1179:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1180:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1173
    adr x0, compile_prefix_bitwise_not
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1182
    tst x1, #1
    b.eq do_concat_1182
do_apply_1181:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1183
do_concat_1182:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1183:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1185
    tst x1, #1
    b.eq do_concat_1185
do_apply_1184:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1186
do_concat_1185:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1186:
    b cond_end_1174
cond_false_1173:
    adr x0, sign_id
cond_end_1174:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    adr x0, str_37
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1144
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1188
    tst x1, #1
    b.eq do_concat_1188
do_apply_1187:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1189
do_concat_1188:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1189:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1191
    tst x1, #1
    b.eq do_concat_1191
do_apply_1190:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1192
do_concat_1191:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1192:
blk_end_1144:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1194
    tst x1, #1
    b.eq do_concat_1194
do_apply_1193:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1195
do_concat_1194:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1195:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1139
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1197
    tst x1, #1
    b.eq do_concat_1197
do_apply_1196:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1198
do_concat_1197:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1198:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1200
    tst x1, #1
    b.eq do_concat_1200
do_apply_1199:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1201
do_concat_1200:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1201:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1203
    tst x1, #1
    b.eq do_concat_1203
do_apply_1202:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1204
do_concat_1203:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1204:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1206
    tst x1, #1
    b.eq do_concat_1206
do_apply_1205:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1207
do_concat_1206:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1207:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1209
    tst x1, #1
    b.eq do_concat_1209
do_apply_1208:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1210
do_concat_1209:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1210:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1212
    tst x1, #1
    b.eq do_concat_1212
do_apply_1211:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1213
do_concat_1212:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1213:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1215
    tst x1, #1
    b.eq do_concat_1215
do_apply_1214:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1216
do_concat_1215:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1216:
blk_end_1139:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1137_1138:
    // Closure for func_1137
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1137
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1131
cond_false_1130:
    adr x0, sign_id
cond_end_1131:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_prefix_at
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1220
    tst x1, #1
    b.eq do_concat_1220
do_apply_1219:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1221
do_concat_1220:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1221:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1217
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
    adr x0, expr_is_zero_num
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1230
    tst x1, #1
    b.eq do_concat_1230
do_apply_1229:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1231
do_concat_1230:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1231:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1227
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_38
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1233
    tst x1, #1
    b.eq do_concat_1233
do_apply_1232:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1234
do_concat_1233:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1234:
    b cond_end_1228
cond_false_1227:
    adr x0, sign_id
cond_end_1228:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1226
    b after_func_1235_1236
func_1235:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1235_1236:
    // Closure for func_1235
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1235
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1238_1239
func_1238:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1240_1241
func_1240:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1240_1241:
    // Closure for func_1240
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1240
    ldr x0, [sp], #16
    bl _cons
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
    str x0, [sp, #-16]!
    adr x0, asm
    str x0, [sp, #-16]!
    adr x0, str_39
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0
    ldr x0, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, ctx_new
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1243
    tst x1, #1
    b.eq do_concat_1243
do_apply_1242:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1244
do_concat_1243:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1244:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1237
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1246
    tst x1, #1
    b.eq do_concat_1246
do_apply_1245:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1247
do_concat_1246:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1247:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1249
    tst x1, #1
    b.eq do_concat_1249
do_apply_1248:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1250
do_concat_1249:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1250:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1252
    tst x1, #1
    b.eq do_concat_1252
do_apply_1251:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1253
do_concat_1252:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1253:
blk_end_1237:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1255
    tst x1, #1
    b.eq do_concat_1255
do_apply_1254:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1256
do_concat_1255:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1256:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1226
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1258
    tst x1, #1
    b.eq do_concat_1258
do_apply_1257:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1259
do_concat_1258:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1259:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1261
    tst x1, #1
    b.eq do_concat_1261
do_apply_1260:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1262
do_concat_1261:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1262:
blk_end_1226:
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
    b cond_end_1218
cond_false_1217:
    adr x0, sign_id
cond_end_1218:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, expr_is_zero_num
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1266
    tst x1, #1
    b.eq do_concat_1266
do_apply_1265:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1267
do_concat_1266:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1267:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1263
    b after_func_1268_1269
func_1268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1275
    tst x1, #1
    b.eq do_concat_1275
do_apply_1274:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1276
do_concat_1275:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1276:
    str x0, [sp, #-16]!
    adr x0, ast_num
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1272
    adr x0, sign_id
    b cmp_end_1273
cmp_true_1272:
cmp_end_1273:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1270
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1280
    tst x1, #1
    b.eq do_concat_1280
do_apply_1279:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1281
do_concat_1280:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1281:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1283
    tst x1, #1
    b.eq do_concat_1283
do_apply_1282:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1284
do_concat_1283:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1284:
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1277
    adr x0, sign_id
    b cmp_end_1278
cmp_true_1277:
cmp_end_1278:
    b and_end_1271
and_fail_1270:
    adr x0, sign_id
and_end_1271:
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
    b cond_end_1264
cond_false_1263:
    adr x0, sign_id
cond_end_1264:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_prefix_not
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1288
    tst x1, #1
    b.eq do_concat_1288
do_apply_1287:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1289
do_concat_1288:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1289:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1285
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
    b after_func_1294_1295
func_1294:
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
    b.eq or_right_1297
    b or_end_1298
or_right_1297:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1300
    tst x1, #1
    b.eq do_concat_1300
do_apply_1299:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1301
do_concat_1300:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1301:
    str x0, [sp, #-16]!
    adr x0, str_40
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1303
    tst x1, #1
    b.eq do_concat_1303
do_apply_1302:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1304
do_concat_1303:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1304:
or_end_1298:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1296
    b after_func_1305_1306
func_1305:
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
    b.eq or_right_1308
    b or_end_1309
or_right_1308:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1311
    tst x1, #1
    b.eq do_concat_1311
do_apply_1310:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1312
do_concat_1311:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1312:
or_end_1309:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1307
    b after_func_1313_1314
func_1313:
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
    b.eq or_right_1316
    b or_end_1317
or_right_1316:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1319
    tst x1, #1
    b.eq do_concat_1319
do_apply_1318:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1320
do_concat_1319:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1320:
    str x0, [sp, #-16]!
    adr x0, str_41
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1322
    tst x1, #1
    b.eq do_concat_1322
do_apply_1321:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1323
do_concat_1322:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1323:
or_end_1317:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1315
    b after_func_1324_1325
func_1324:
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
    b.eq or_right_1327
    b or_end_1328
or_right_1327:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1330
    tst x1, #1
    b.eq do_concat_1330
do_apply_1329:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1331
do_concat_1330:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1331:
or_end_1328:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1326
    b after_func_1332_1333
func_1332:
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
    b.eq or_right_1335
    b or_end_1336
or_right_1335:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1338
    tst x1, #1
    b.eq do_concat_1338
do_apply_1337:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1339
do_concat_1338:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1339:
or_end_1336:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1334
    b after_func_1340_1341
func_1340:
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
    b.eq or_right_1343
    b or_end_1344
or_right_1343:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1346
    tst x1, #1
    b.eq do_concat_1346
do_apply_1345:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1347
do_concat_1346:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1347:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1349
    tst x1, #1
    b.eq do_concat_1349
do_apply_1348:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1350
do_concat_1349:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1350:
or_end_1344:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1342
    b after_func_1351_1352
func_1351:
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
    b.eq or_right_1354
    b or_end_1355
or_right_1354:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1357
    tst x1, #1
    b.eq do_concat_1357
do_apply_1356:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1358
do_concat_1357:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1358:
or_end_1355:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1353
    b after_func_1359_1360
func_1359:
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
    b.eq or_right_1362
    b or_end_1363
or_right_1362:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1365
    tst x1, #1
    b.eq do_concat_1365
do_apply_1364:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1366
do_concat_1365:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1366:
or_end_1363:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1361
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_42
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_43
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1367
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_15
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1369
    tst x1, #1
    b.eq do_concat_1369
do_apply_1368:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1370
do_concat_1369:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1370:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1372
    tst x1, #1
    b.eq do_concat_1372
do_apply_1371:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1373
do_concat_1372:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1373:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1375
    tst x1, #1
    b.eq do_concat_1375
do_apply_1374:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1376
do_concat_1375:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1376:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1378
    tst x1, #1
    b.eq do_concat_1378
do_apply_1377:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1379
do_concat_1378:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1379:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1367
    adr x0, str_35
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1367
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_20
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1381
    tst x1, #1
    b.eq do_concat_1381
do_apply_1380:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1382
do_concat_1381:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1382:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1384
    tst x1, #1
    b.eq do_concat_1384
do_apply_1383:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1385
do_concat_1384:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1385:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1387
    tst x1, #1
    b.eq do_concat_1387
do_apply_1386:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1388
do_concat_1387:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1388:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1390
    tst x1, #1
    b.eq do_concat_1390
do_apply_1389:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1391
do_concat_1390:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1391:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1367
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1393
    tst x1, #1
    b.eq do_concat_1393
do_apply_1392:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1394
do_concat_1393:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1394:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1396
    tst x1, #1
    b.eq do_concat_1396
do_apply_1395:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1397
do_concat_1396:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1397:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1367
    adr x0, str_44
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1367
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1399
    tst x1, #1
    b.eq do_concat_1399
do_apply_1398:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1400
do_concat_1399:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1400:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1402
    tst x1, #1
    b.eq do_concat_1402
do_apply_1401:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1403
do_concat_1402:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1403:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_1367:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1405
    tst x1, #1
    b.eq do_concat_1405
do_apply_1404:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1406
do_concat_1405:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1406:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1408
    tst x1, #1
    b.eq do_concat_1408
do_apply_1407:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1409
do_concat_1408:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1409:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_1361:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1359_1360:
    // Closure for func_1359
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
    adr x1, func_1359
    ldr x0, [sp], #16
    bl _cons
blk_end_1353:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1351_1352:
    // Closure for func_1351
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
    adr x1, func_1351
    ldr x0, [sp], #16
    bl _cons
blk_end_1342:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1340_1341:
    // Closure for func_1340
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
    adr x1, func_1340
    ldr x0, [sp], #16
    bl _cons
blk_end_1334:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1332_1333:
    // Closure for func_1332
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
    adr x1, func_1332
    ldr x0, [sp], #16
    bl _cons
blk_end_1326:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1324_1325:
    // Closure for func_1324
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
    adr x1, func_1324
    ldr x0, [sp], #16
    bl _cons
blk_end_1315:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1313_1314:
    // Closure for func_1313
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
    adr x1, func_1313
    ldr x0, [sp], #16
    bl _cons
blk_end_1307:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1305_1306:
    // Closure for func_1305
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
    adr x1, func_1305
    ldr x0, [sp], #16
    bl _cons
blk_end_1296:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1294_1295:
    // Closure for func_1294
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
    adr x1, func_1294
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_1286
cond_false_1285:
    adr x0, sign_id
cond_end_1286:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_prefix_bitwise_not
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1413
    tst x1, #1
    b.eq do_concat_1413
do_apply_1412:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1414
do_concat_1413:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1414:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1410
    b after_func_1415_1416
func_1415:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1417_1418
func_1417:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1420_1421
func_1420:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1420_1421:
    // Closure for func_1420
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1420
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1423_1424
func_1423:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1425_1426
func_1425:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1425_1426:
    // Closure for func_1425
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1425
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1423_1424:
    // Closure for func_1423
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1423
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, asm
    str x0, [sp, #-16]!
    adr x0, str_45
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0
    ldr x0, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, ctx_new
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1428
    tst x1, #1
    b.eq do_concat_1428
do_apply_1427:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1429
do_concat_1428:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1429:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1422
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1431
    tst x1, #1
    b.eq do_concat_1431
do_apply_1430:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1432
do_concat_1431:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1432:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1434
    tst x1, #1
    b.eq do_concat_1434
do_apply_1433:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1435
do_concat_1434:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1435:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1437
    tst x1, #1
    b.eq do_concat_1437
do_apply_1436:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1438
do_concat_1437:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1438:
blk_end_1422:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1440
    tst x1, #1
    b.eq do_concat_1440
do_apply_1439:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1441
do_concat_1440:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1441:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1419
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1443
    tst x1, #1
    b.eq do_concat_1443
do_apply_1442:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1444
do_concat_1443:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1444:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1446
    tst x1, #1
    b.eq do_concat_1446
do_apply_1445:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1447
do_concat_1446:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1447:
blk_end_1419:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1417_1418:
    // Closure for func_1417
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1417
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1415_1416:
    // Closure for func_1415
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1415
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1411
cond_false_1410:
    adr x0, sign_id
cond_end_1411:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_postfix
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1451
    tst x1, #1
    b.eq do_concat_1451
do_apply_1450:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1452
do_concat_1451:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1452:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1448
    b after_func_1453_1454
func_1453:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1455_1456
func_1455:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1458_1459
func_1458:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1460_1461
func_1460:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1460_1461:
    // Closure for func_1460
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1460
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1458_1459:
    // Closure for func_1458
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1458
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1466
    tst x1, #1
    b.eq do_concat_1466
do_apply_1465:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1467
do_concat_1466:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1467:
    str x0, [sp, #-16]!
    mov x0, #33
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1469
    tst x1, #1
    b.eq do_concat_1469
do_apply_1468:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1470
do_concat_1469:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1470:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1463
    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_1472_1473
func_1472:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1472_1473:
    // Closure for func_1472
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1472
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_1475_1476
func_1475:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1477_1478
func_1477:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1477_1478:
    // Closure for func_1477
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1477
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1475_1476:
    // Closure for func_1475
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1475
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
    mov x1, x0
    ldr x0, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, ctx_new
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1480
    tst x1, #1
    b.eq do_concat_1480
do_apply_1479:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1481
do_concat_1480:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1481:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1474
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1483
    tst x1, #1
    b.eq do_concat_1483
do_apply_1482:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1484
do_concat_1483:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1484:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1486
    tst x1, #1
    b.eq do_concat_1486
do_apply_1485:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1487
do_concat_1486:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1487:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1489
    tst x1, #1
    b.eq do_concat_1489
do_apply_1488:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1490
do_concat_1489:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1490:
blk_end_1474:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1492
    tst x1, #1
    b.eq do_concat_1492
do_apply_1491:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1493
do_concat_1492:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1493:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1471
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1495
    tst x1, #1
    b.eq do_concat_1495
do_apply_1494:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1496
do_concat_1495:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1496:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1498
    tst x1, #1
    b.eq do_concat_1498
do_apply_1497:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1499
do_concat_1498:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1499:
blk_end_1471:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1501
    tst x1, #1
    b.eq do_concat_1501
do_apply_1500:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1502
do_concat_1501:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1502:
    b cond_end_1464
cond_false_1463:
    adr x0, sign_id
cond_end_1464:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1462
    adr x0, str_37
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1462
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1504
    tst x1, #1
    b.eq do_concat_1504
do_apply_1503:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1505
do_concat_1504:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1505:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1507
    tst x1, #1
    b.eq do_concat_1507
do_apply_1506:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1508
do_concat_1507:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1508:
blk_end_1462:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1510
    tst x1, #1
    b.eq do_concat_1510
do_apply_1509:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1511
do_concat_1510:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1511:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1457
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1513
    tst x1, #1
    b.eq do_concat_1513
do_apply_1512:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1514
do_concat_1513:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1514:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1516
    tst x1, #1
    b.eq do_concat_1516
do_apply_1515:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1517
do_concat_1516:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1517:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1519
    tst x1, #1
    b.eq do_concat_1519
do_apply_1518:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1520
do_concat_1519:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1520:
    str x0, [sp, #-16]!
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1522
    tst x1, #1
    b.eq do_concat_1522
do_apply_1521:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1523
do_concat_1522:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1523:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1525
    tst x1, #1
    b.eq do_concat_1525
do_apply_1524:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1526
do_concat_1525:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1526:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1528
    tst x1, #1
    b.eq do_concat_1528
do_apply_1527:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1529
do_concat_1528:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1529:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1531
    tst x1, #1
    b.eq do_concat_1531
do_apply_1530:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1532
do_concat_1531:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1532:
blk_end_1457:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1455_1456:
    // Closure for func_1455
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1455
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1453_1454:
    // Closure for func_1453
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1453
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1449
cond_false_1448:
    adr x0, sign_id
cond_end_1449:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_infix
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1536
    tst x1, #1
    b.eq do_concat_1536
do_apply_1535:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1537
do_concat_1536:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1537:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1533
    b after_func_1538_1539
func_1538:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1540_1541
func_1540:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1543_1544
func_1543:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1543_1544:
    // Closure for func_1543
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1543
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1549
    tst x1, #1
    b.eq do_concat_1549
do_apply_1548:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1550
do_concat_1549:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1550:
    str x0, [sp, #-16]!
    mov x0, #43
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1552
    tst x1, #1
    b.eq do_concat_1552
do_apply_1551:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1553
do_concat_1552:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1553:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1546
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1555
    tst x1, #1
    b.eq do_concat_1555
do_apply_1554:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1556
do_concat_1555:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1556:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1558
    tst x1, #1
    b.eq do_concat_1558
do_apply_1557:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1559
do_concat_1558:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1559:
    str x0, [sp, #-16]!
    adr x0, str_47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1561
    tst x1, #1
    b.eq do_concat_1561
do_apply_1560:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1562
do_concat_1561:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1562:
    b cond_end_1547
cond_false_1546:
    adr x0, sign_id
cond_end_1547:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1566
    tst x1, #1
    b.eq do_concat_1566
do_apply_1565:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1567
do_concat_1566:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1567:
    str x0, [sp, #-16]!
    mov x0, #45
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1569
    tst x1, #1
    b.eq do_concat_1569
do_apply_1568:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1570
do_concat_1569:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1570:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1563
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1572
    tst x1, #1
    b.eq do_concat_1572
do_apply_1571:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1573
do_concat_1572:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1573:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1575
    tst x1, #1
    b.eq do_concat_1575
do_apply_1574:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1576
do_concat_1575:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1576:
    str x0, [sp, #-16]!
    adr x0, str_48
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1578
    tst x1, #1
    b.eq do_concat_1578
do_apply_1577:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1579
do_concat_1578:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1579:
    b cond_end_1564
cond_false_1563:
    adr x0, sign_id
cond_end_1564:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1583
    tst x1, #1
    b.eq do_concat_1583
do_apply_1582:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1584
do_concat_1583:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1584:
    str x0, [sp, #-16]!
    mov x0, #42
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1586
    tst x1, #1
    b.eq do_concat_1586
do_apply_1585:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1587
do_concat_1586:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1587:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1580
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1589
    tst x1, #1
    b.eq do_concat_1589
do_apply_1588:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1590
do_concat_1589:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1590:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1592
    tst x1, #1
    b.eq do_concat_1592
do_apply_1591:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1593
do_concat_1592:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1593:
    str x0, [sp, #-16]!
    adr x0, str_49
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1595
    tst x1, #1
    b.eq do_concat_1595
do_apply_1594:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1596
do_concat_1595:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1596:
    b cond_end_1581
cond_false_1580:
    adr x0, sign_id
cond_end_1581:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1600
    tst x1, #1
    b.eq do_concat_1600
do_apply_1599:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1601
do_concat_1600:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1601:
    str x0, [sp, #-16]!
    mov x0, #47
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1603
    tst x1, #1
    b.eq do_concat_1603
do_apply_1602:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1604
do_concat_1603:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1604:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1597
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1606
    tst x1, #1
    b.eq do_concat_1606
do_apply_1605:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1607
do_concat_1606:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1607:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1609
    tst x1, #1
    b.eq do_concat_1609
do_apply_1608:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1610
do_concat_1609:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1610:
    str x0, [sp, #-16]!
    adr x0, str_50
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1612
    tst x1, #1
    b.eq do_concat_1612
do_apply_1611:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1613
do_concat_1612:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1613:
    b cond_end_1598
cond_false_1597:
    adr x0, sign_id
cond_end_1598:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1617
    tst x1, #1
    b.eq do_concat_1617
do_apply_1616:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1618
do_concat_1617:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1618:
    str x0, [sp, #-16]!
    mov x0, #61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1620
    tst x1, #1
    b.eq do_concat_1620
do_apply_1619:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1621
do_concat_1620:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1621:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1614
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1623
    tst x1, #1
    b.eq do_concat_1623
do_apply_1622:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1624
do_concat_1623:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1624:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1626
    tst x1, #1
    b.eq do_concat_1626
do_apply_1625:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1627
do_concat_1626:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1627:
    str x0, [sp, #-16]!
    adr x0, str_51
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1629
    tst x1, #1
    b.eq do_concat_1629
do_apply_1628:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1630
do_concat_1629:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1630:
    b cond_end_1615
cond_false_1614:
    adr x0, sign_id
cond_end_1615:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1634
    tst x1, #1
    b.eq do_concat_1634
do_apply_1633:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1635
do_concat_1634:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1635:
    str x0, [sp, #-16]!
    adr x0, str_52
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1637
    tst x1, #1
    b.eq do_concat_1637
do_apply_1636:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1638
do_concat_1637:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1638:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1631
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1640
    tst x1, #1
    b.eq do_concat_1640
do_apply_1639:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1641
do_concat_1640:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1641:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1643
    tst x1, #1
    b.eq do_concat_1643
do_apply_1642:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1644
do_concat_1643:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1644:
    str x0, [sp, #-16]!
    adr x0, str_53
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1646
    tst x1, #1
    b.eq do_concat_1646
do_apply_1645:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1647
do_concat_1646:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1647:
    b cond_end_1632
cond_false_1631:
    adr x0, sign_id
cond_end_1632:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1651
    tst x1, #1
    b.eq do_concat_1651
do_apply_1650:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1652
do_concat_1651:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1652:
    str x0, [sp, #-16]!
    mov x0, #60
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1654
    tst x1, #1
    b.eq do_concat_1654
do_apply_1653:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1655
do_concat_1654:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1655:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1648
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1657
    tst x1, #1
    b.eq do_concat_1657
do_apply_1656:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1658
do_concat_1657:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1658:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1660
    tst x1, #1
    b.eq do_concat_1660
do_apply_1659:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1661
do_concat_1660:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1661:
    str x0, [sp, #-16]!
    adr x0, str_54
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1663
    tst x1, #1
    b.eq do_concat_1663
do_apply_1662:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1664
do_concat_1663:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1664:
    b cond_end_1649
cond_false_1648:
    adr x0, sign_id
cond_end_1649:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1668
    tst x1, #1
    b.eq do_concat_1668
do_apply_1667:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1669
do_concat_1668:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1669:
    str x0, [sp, #-16]!
    mov x0, #62
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1671
    tst x1, #1
    b.eq do_concat_1671
do_apply_1670:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1672
do_concat_1671:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1672:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1665
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1674
    tst x1, #1
    b.eq do_concat_1674
do_apply_1673:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1675
do_concat_1674:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1675:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1677
    tst x1, #1
    b.eq do_concat_1677
do_apply_1676:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1678
do_concat_1677:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1678:
    str x0, [sp, #-16]!
    adr x0, str_55
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1680
    tst x1, #1
    b.eq do_concat_1680
do_apply_1679:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1681
do_concat_1680:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1681:
    b cond_end_1666
cond_false_1665:
    adr x0, sign_id
cond_end_1666:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1685
    tst x1, #1
    b.eq do_concat_1685
do_apply_1684:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1686
do_concat_1685:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1686:
    str x0, [sp, #-16]!
    adr x0, str_56
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1688
    tst x1, #1
    b.eq do_concat_1688
do_apply_1687:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1689
do_concat_1688:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1689:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1682
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1691
    tst x1, #1
    b.eq do_concat_1691
do_apply_1690:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1692
do_concat_1691:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1692:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1694
    tst x1, #1
    b.eq do_concat_1694
do_apply_1693:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1695
do_concat_1694:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1695:
    str x0, [sp, #-16]!
    adr x0, str_57
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1697
    tst x1, #1
    b.eq do_concat_1697
do_apply_1696:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1698
do_concat_1697:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1698:
    b cond_end_1683
cond_false_1682:
    adr x0, sign_id
cond_end_1683:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1702
    tst x1, #1
    b.eq do_concat_1702
do_apply_1701:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1703
do_concat_1702:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1703:
    str x0, [sp, #-16]!
    adr x0, str_58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1705
    tst x1, #1
    b.eq do_concat_1705
do_apply_1704:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1706
do_concat_1705:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1706:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1699
    adr x0, compile_cmp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1708
    tst x1, #1
    b.eq do_concat_1708
do_apply_1707:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1709
do_concat_1708:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1709:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1711
    tst x1, #1
    b.eq do_concat_1711
do_apply_1710:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1712
do_concat_1711:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1712:
    str x0, [sp, #-16]!
    adr x0, str_59
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1714
    tst x1, #1
    b.eq do_concat_1714
do_apply_1713:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1715
do_concat_1714:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1715:
    b cond_end_1700
cond_false_1699:
    adr x0, sign_id
cond_end_1700:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1719
    tst x1, #1
    b.eq do_concat_1719
do_apply_1718:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1720
do_concat_1719:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1720:
    str x0, [sp, #-16]!
    mov x0, #124
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1722
    tst x1, #1
    b.eq do_concat_1722
do_apply_1721:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1723
do_concat_1722:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1723:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1716
    adr x0, compile_logic_or
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1725
    tst x1, #1
    b.eq do_concat_1725
do_apply_1724:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1726
do_concat_1725:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1726:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1728
    tst x1, #1
    b.eq do_concat_1728
do_apply_1727:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1729
do_concat_1728:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1729:
    b cond_end_1717
cond_false_1716:
    adr x0, sign_id
cond_end_1717:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1733
    tst x1, #1
    b.eq do_concat_1733
do_apply_1732:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1734
do_concat_1733:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1734:
    str x0, [sp, #-16]!
    adr x0, str_60
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1736
    tst x1, #1
    b.eq do_concat_1736
do_apply_1735:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1737
do_concat_1736:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1737:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1730
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1739
    tst x1, #1
    b.eq do_concat_1739
do_apply_1738:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1740
do_concat_1739:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1740:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1742
    tst x1, #1
    b.eq do_concat_1742
do_apply_1741:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1743
do_concat_1742:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1743:
    str x0, [sp, #-16]!
    adr x0, str_61
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1745
    tst x1, #1
    b.eq do_concat_1745
do_apply_1744:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1746
do_concat_1745:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1746:
    b cond_end_1731
cond_false_1730:
    adr x0, sign_id
cond_end_1731:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1750
    tst x1, #1
    b.eq do_concat_1750
do_apply_1749:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1751
do_concat_1750:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1751:
    str x0, [sp, #-16]!
    mov x0, #38
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1753
    tst x1, #1
    b.eq do_concat_1753
do_apply_1752:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1754
do_concat_1753:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1754:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1747
    adr x0, compile_logic_and
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1756
    tst x1, #1
    b.eq do_concat_1756
do_apply_1755:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1757
do_concat_1756:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1757:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1759
    tst x1, #1
    b.eq do_concat_1759
do_apply_1758:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1760
do_concat_1759:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1760:
    b cond_end_1748
cond_false_1747:
    adr x0, sign_id
cond_end_1748:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1764
    tst x1, #1
    b.eq do_concat_1764
do_apply_1763:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1765
do_concat_1764:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1765:
    str x0, [sp, #-16]!
    mov x0, #44
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1767
    tst x1, #1
    b.eq do_concat_1767
do_apply_1766:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1768
do_concat_1767:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1768:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1761
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1770
    tst x1, #1
    b.eq do_concat_1770
do_apply_1769:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1771
do_concat_1770:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1771:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1773
    tst x1, #1
    b.eq do_concat_1773
do_apply_1772:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1774
do_concat_1773:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1774:
    str x0, [sp, #-16]!
    adr x0, str_62
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1776
    tst x1, #1
    b.eq do_concat_1776
do_apply_1775:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1777
do_concat_1776:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1777:
    b cond_end_1762
cond_false_1761:
    adr x0, sign_id
cond_end_1762:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1781
    tst x1, #1
    b.eq do_concat_1781
do_apply_1780:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1782
do_concat_1781:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1782:
    str x0, [sp, #-16]!
    mov x0, #126
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1784
    tst x1, #1
    b.eq do_concat_1784
do_apply_1783:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1785
do_concat_1784:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1785:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1778
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1787
    tst x1, #1
    b.eq do_concat_1787
do_apply_1786:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1788
do_concat_1787:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1788:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1790
    tst x1, #1
    b.eq do_concat_1790
do_apply_1789:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1791
do_concat_1790:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1791:
    str x0, [sp, #-16]!
    adr x0, str_6
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1793
    tst x1, #1
    b.eq do_concat_1793
do_apply_1792:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1794
do_concat_1793:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1794:
    b cond_end_1779
cond_false_1778:
    adr x0, sign_id
cond_end_1779:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1798
    tst x1, #1
    b.eq do_concat_1798
do_apply_1797:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1799
do_concat_1798:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1799:
    str x0, [sp, #-16]!
    adr x0, str_63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1801
    tst x1, #1
    b.eq do_concat_1801
do_apply_1800:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1802
do_concat_1801:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1802:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1795
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1804
    tst x1, #1
    b.eq do_concat_1804
do_apply_1803:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1805
do_concat_1804:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1805:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1807
    tst x1, #1
    b.eq do_concat_1807
do_apply_1806:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1808
do_concat_1807:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1808:
    str x0, [sp, #-16]!
    adr x0, str_64
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1810
    tst x1, #1
    b.eq do_concat_1810
do_apply_1809:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1811
do_concat_1810:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1811:
    b cond_end_1796
cond_false_1795:
    adr x0, sign_id
cond_end_1796:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1815
    tst x1, #1
    b.eq do_concat_1815
do_apply_1814:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1816
do_concat_1815:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1816:
    str x0, [sp, #-16]!
    mov x0, #39
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1818
    tst x1, #1
    b.eq do_concat_1818
do_apply_1817:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1819
do_concat_1818:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1819:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1812
    adr x0, compile_binop
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1821
    tst x1, #1
    b.eq do_concat_1821
do_apply_1820:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1822
do_concat_1821:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1822:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1824
    tst x1, #1
    b.eq do_concat_1824
do_apply_1823:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1825
do_concat_1824:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1825:
    str x0, [sp, #-16]!
    adr x0, str_65
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1827
    tst x1, #1
    b.eq do_concat_1827
do_apply_1826:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1828
do_concat_1827:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1828:
    b cond_end_1813
cond_false_1812:
    adr x0, sign_id
cond_end_1813:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1832
    tst x1, #1
    b.eq do_concat_1832
do_apply_1831:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1833
do_concat_1832:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1833:
    str x0, [sp, #-16]!
    mov x0, #58
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1835
    tst x1, #1
    b.eq do_concat_1835
do_apply_1834:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1836
do_concat_1835:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1836:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1829
    adr x0, compile_bind
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1838
    tst x1, #1
    b.eq do_concat_1838
do_apply_1837:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1839
do_concat_1838:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1839:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1841
    tst x1, #1
    b.eq do_concat_1841
do_apply_1840:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1842
do_concat_1841:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1842:
    b cond_end_1830
cond_false_1829:
    adr x0, sign_id
cond_end_1830:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, streq
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1846
    tst x1, #1
    b.eq do_concat_1846
do_apply_1845:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1847
do_concat_1846:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1847:
    str x0, [sp, #-16]!
    mov x0, #63
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1849
    tst x1, #1
    b.eq do_concat_1849
do_apply_1848:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1850
do_concat_1849:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1850:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1843
    adr x0, compile_lambda
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1852
    tst x1, #1
    b.eq do_concat_1852
do_apply_1851:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1853
do_concat_1852:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1853:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1855
    tst x1, #1
    b.eq do_concat_1855
do_apply_1854:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1856
do_concat_1855:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1856:
    b cond_end_1844
cond_false_1843:
    adr x0, sign_id
cond_end_1844:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, str_32
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1545
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_66
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1858
    tst x1, #1
    b.eq do_concat_1858
do_apply_1857:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1859
do_concat_1858:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1859:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, op
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1861
    tst x1, #1
    b.eq do_concat_1861
do_apply_1860:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1862
do_concat_1861:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1862:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1864
    tst x1, #1
    b.eq do_concat_1864
do_apply_1863:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1865
do_concat_1864:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1865:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1867
    tst x1, #1
    b.eq do_concat_1867
do_apply_1866:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1868
do_concat_1867:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1868:
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
blk_end_1545:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1870
    tst x1, #1
    b.eq do_concat_1870
do_apply_1869:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1871
do_concat_1870:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1871:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1542
    adr x0, tok_val
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1873
    tst x1, #1
    b.eq do_concat_1873
do_apply_1872:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1874
do_concat_1873:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1874:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1876
    tst x1, #1
    b.eq do_concat_1876
do_apply_1875:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1877
do_concat_1876:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1877:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1879
    tst x1, #1
    b.eq do_concat_1879
do_apply_1878:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1880
do_concat_1879:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1880:
blk_end_1542:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1540_1541:
    // Closure for func_1540
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1540
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1538_1539:
    // Closure for func_1538
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1538
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1534
cond_false_1533:
    adr x0, sign_id
cond_end_1534:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_bind
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1884
    tst x1, #1
    b.eq do_concat_1884
do_apply_1883:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1885
do_concat_1884:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1885:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1881
    b after_func_1886_1887
func_1886:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1888_1889
func_1888:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_1890_1891
func_1890:
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
    b.eq or_right_1893
    b or_end_1894
or_right_1893:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1896
    tst x1, #1
    b.eq do_concat_1896
do_apply_1895:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1897
do_concat_1896:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1897:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1899
    tst x1, #1
    b.eq do_concat_1899
do_apply_1898:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1900
do_concat_1899:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1900:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1902
    tst x1, #1
    b.eq do_concat_1902
do_apply_1901:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1903
do_concat_1902:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1903:
or_end_1894:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1892
    b after_func_1904_1905
func_1904:
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
    b.eq or_right_1907
    b or_end_1908
or_right_1907:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1910
    tst x1, #1
    b.eq do_concat_1910
do_apply_1909:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1911
do_concat_1910:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1911:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1913
    tst x1, #1
    b.eq do_concat_1913
do_apply_1912:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1914
do_concat_1913:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1914:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1916
    tst x1, #1
    b.eq do_concat_1916
do_apply_1915:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1917
do_concat_1916:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1917:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1919
    tst x1, #1
    b.eq do_concat_1919
do_apply_1918:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1920
do_concat_1919:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1920:
or_end_1908:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1906
    b after_func_1921_1922
func_1921:
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
    b.eq or_right_1924
    b or_end_1925
or_right_1924:
    adr x0, tok_val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1927
    tst x1, #1
    b.eq do_concat_1927
do_apply_1926:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1928
do_concat_1927:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1928:
or_end_1925:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1923
    b after_func_1929_1930
func_1929:
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
    b.eq or_right_1932
    b or_end_1933
or_right_1932:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1935
    tst x1, #1
    b.eq do_concat_1935
do_apply_1934:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1936
do_concat_1935:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1936:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1938
    tst x1, #1
    b.eq do_concat_1938
do_apply_1937:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1939
do_concat_1938:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1939:
or_end_1933:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1931
    b after_func_1940_1941
func_1940:
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
    b.eq or_right_1943
    b or_end_1944
or_right_1943:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1946
    tst x1, #1
    b.eq do_concat_1946
do_apply_1945:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1947
do_concat_1946:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1947:
or_end_1944:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1942
    b after_func_1948_1949
func_1948:
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
    b.eq or_right_1951
    b or_end_1952
or_right_1951:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1954
    tst x1, #1
    b.eq do_concat_1954
do_apply_1953:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1955
do_concat_1954:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1955:
or_end_1952:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1950
    b after_func_1956_1957
func_1956:
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
    b.eq or_right_1959
    b or_end_1960
or_right_1959:
    adr x0, push_var
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1962
    tst x1, #1
    b.eq do_concat_1962
do_apply_1961:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1963
do_concat_1962:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1963:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1965
    tst x1, #1
    b.eq do_concat_1965
do_apply_1964:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1966
do_concat_1965:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1966:
or_end_1960:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1958
    ldr x0, [x29, #-80]
    str x0, [sp, #-16]!
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, str_35
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
blk_end_1958:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1956_1957:
    // Closure for func_1956
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
    adr x1, func_1956
    ldr x0, [sp], #16
    bl _cons
blk_end_1950:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1948_1949:
    // Closure for func_1948
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
    adr x1, func_1948
    ldr x0, [sp], #16
    bl _cons
blk_end_1942:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1940_1941:
    // Closure for func_1940
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
    adr x1, func_1940
    ldr x0, [sp], #16
    bl _cons
blk_end_1931:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1929_1930:
    // Closure for func_1929
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
    adr x1, func_1929
    ldr x0, [sp], #16
    bl _cons
blk_end_1923:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1921_1922:
    // Closure for func_1921
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
    adr x1, func_1921
    ldr x0, [sp], #16
    bl _cons
blk_end_1906:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1904_1905:
    // Closure for func_1904
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
    adr x1, func_1904
    ldr x0, [sp], #16
    bl _cons
blk_end_1892:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1890_1891:
    // Closure for func_1890
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
    adr x1, func_1890
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1888_1889:
    // Closure for func_1888
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1888
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1886_1887:
    // Closure for func_1886
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1886
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1882
cond_false_1881:
    adr x0, sign_id
cond_end_1882:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_lambda
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1970
    tst x1, #1
    b.eq do_concat_1970
do_apply_1969:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1971
do_concat_1970:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1971:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_1967
    b after_func_1972_1973
func_1972:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_1974_1975
func_1974:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
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
    ldr x0, [x29, #-32]
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_1979
    b or_end_1980
or_right_1979:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1982
    tst x1, #1
    b.eq do_concat_1982
do_apply_1981:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1983
do_concat_1982:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1983:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1985
    tst x1, #1
    b.eq do_concat_1985
do_apply_1984:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1986
do_concat_1985:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1986:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1988
    tst x1, #1
    b.eq do_concat_1988
do_apply_1987:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1989
do_concat_1988:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1989:
or_end_1980:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1978
    b after_func_1990_1991
func_1990:
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
    b.eq or_right_1993
    b or_end_1994
or_right_1993:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1996
    tst x1, #1
    b.eq do_concat_1996
do_apply_1995:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_1997
do_concat_1996:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_1997:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_1999
    tst x1, #1
    b.eq do_concat_1999
do_apply_1998:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2000
do_concat_1999:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2000:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2002
    tst x1, #1
    b.eq do_concat_2002
do_apply_2001:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2003
do_concat_2002:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2003:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2005
    tst x1, #1
    b.eq do_concat_2005
do_apply_2004:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2006
do_concat_2005:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2006:
or_end_1994:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_1992
    b after_func_2007_2008
func_2007:
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
    b.eq or_right_2010
    b or_end_2011
or_right_2010:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2013
    tst x1, #1
    b.eq do_concat_2013
do_apply_2012:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2014
do_concat_2013:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2014:
    str x0, [sp, #-16]!
    adr x0, str_67
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2016
    tst x1, #1
    b.eq do_concat_2016
do_apply_2015:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2017
do_concat_2016:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2017:
or_end_2011:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2009
    b after_func_2018_2019
func_2018:
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
    b.eq or_right_2021
    b or_end_2022
or_right_2021:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2024
    tst x1, #1
    b.eq do_concat_2024
do_apply_2023:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2025
do_concat_2024:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2025:
or_end_2022:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2020
    b after_func_2026_2027
func_2026:
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
    b.eq or_right_2029
    b or_end_2030
or_right_2029:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2032
    tst x1, #1
    b.eq do_concat_2032
do_apply_2031:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2033
do_concat_2032:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2033:
or_end_2030:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2028
    b after_func_2034_2035
func_2034:
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
    b.eq or_right_2037
    b or_end_2038
or_right_2037:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2040
    tst x1, #1
    b.eq do_concat_2040
do_apply_2039:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2041
do_concat_2040:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2041:
    str x0, [sp, #-16]!
    adr x0, str_68
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2043
    tst x1, #1
    b.eq do_concat_2043
do_apply_2042:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2044
do_concat_2043:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2044:
or_end_2038:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2036
    b after_func_2045_2046
func_2045:
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
    b.eq or_right_2048
    b or_end_2049
or_right_2048:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2051
    tst x1, #1
    b.eq do_concat_2051
do_apply_2050:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2052
do_concat_2051:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2052:
or_end_2049:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2047
    b after_func_2053_2054
func_2053:
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
    b.eq or_right_2056
    b or_end_2057
or_right_2056:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2059
    tst x1, #1
    b.eq do_concat_2059
do_apply_2058:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2060
do_concat_2059:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2060:
or_end_2057:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2055
    b after_func_2061_2062
func_2061:
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
    b.eq or_right_2064
    b or_end_2065
or_right_2064:
    adr x0, tok_val
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2067
    tst x1, #1
    b.eq do_concat_2067
do_apply_2066:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2068
do_concat_2067:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2068:
or_end_2065:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2063
    b after_func_2069_2070
func_2069:
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
    b.eq or_right_2072
    b or_end_2073
or_right_2072:
    adr x0, push_var
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2075
    tst x1, #1
    b.eq do_concat_2075
do_apply_2074:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2076
do_concat_2075:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2076:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2078
    tst x1, #1
    b.eq do_concat_2078
do_apply_2077:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2079
do_concat_2078:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2079:
or_end_2073:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2071
    b after_func_2080_2081
func_2080:
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
    b.eq or_right_2083
    b or_end_2084
or_right_2083:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2086
    tst x1, #1
    b.eq do_concat_2086
do_apply_2085:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2087
do_concat_2086:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2087:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2089
    tst x1, #1
    b.eq do_concat_2089
do_apply_2088:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2090
do_concat_2089:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2090:
or_end_2084:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2082
    b after_func_2091_2092
func_2091:
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
    b.eq or_right_2094
    b or_end_2095
or_right_2094:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2097
    tst x1, #1
    b.eq do_concat_2097
do_apply_2096:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2098
do_concat_2097:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2098:
or_end_2095:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2093
    b after_func_2099_2100
func_2099:
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
    b.eq or_right_2102
    b or_end_2103
or_right_2102:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2105
    tst x1, #1
    b.eq do_concat_2105
do_apply_2104:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2106
do_concat_2105:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2106:
or_end_2103:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2101
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_20
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2108
    tst x1, #1
    b.eq do_concat_2108
do_apply_2107:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2109
do_concat_2108:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2109:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2111
    tst x1, #1
    b.eq do_concat_2111
do_apply_2110:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2112
do_concat_2111:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2112:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2114
    tst x1, #1
    b.eq do_concat_2114
do_apply_2113:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2115
do_concat_2114:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2115:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2117
    tst x1, #1
    b.eq do_concat_2117
do_apply_2116:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2118
do_concat_2117:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2118:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2121
    tst x1, #1
    b.eq do_concat_2121
do_apply_2120:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2122
do_concat_2121:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2122:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2124
    tst x1, #1
    b.eq do_concat_2124
do_apply_2123:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2125
do_concat_2124:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2125:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2119
    adr x0, str_69
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2119
    adr x0, str_70
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2119
    adr x0, str_71
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_2119:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2127
    tst x1, #1
    b.eq do_concat_2127
do_apply_2126:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2128
do_concat_2127:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2128:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2101
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2101
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_72
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_73
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2129
    adr x0, str_74
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2129
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2131
    tst x1, #1
    b.eq do_concat_2131
do_apply_2130:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2132
do_concat_2131:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2132:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2134
    tst x1, #1
    b.eq do_concat_2134
do_apply_2133:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2135
do_concat_2134:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2135:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2129
    adr x0, str_35
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2129
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2129
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_75
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2137
    tst x1, #1
    b.eq do_concat_2137
do_apply_2136:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2138
do_concat_2137:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2138:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2140
    tst x1, #1
    b.eq do_concat_2140
do_apply_2139:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2141
do_concat_2140:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2141:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2143
    tst x1, #1
    b.eq do_concat_2143
do_apply_2142:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2144
do_concat_2143:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2144:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2146
    tst x1, #1
    b.eq do_concat_2146
do_apply_2145:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2147
do_concat_2146:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2147:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2129
    adr x0, str_5
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2129
    adr x0, str_62
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2129
    adr x0, str_76
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_2129:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2149
    tst x1, #1
    b.eq do_concat_2149
do_apply_2148:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2150
do_concat_2149:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2150:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2152
    tst x1, #1
    b.eq do_concat_2152
do_apply_2151:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2153
do_concat_2152:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2153:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_2101:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2099_2100:
    // Closure for func_2099
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
    adr x1, func_2099
    ldr x0, [sp], #16
    bl _cons
blk_end_2093:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2091_2092:
    // Closure for func_2091
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
    adr x1, func_2091
    ldr x0, [sp], #16
    bl _cons
blk_end_2082:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2080_2081:
    // Closure for func_2080
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
    adr x1, func_2080
    ldr x0, [sp], #16
    bl _cons
blk_end_2071:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2069_2070:
    // Closure for func_2069
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
    adr x1, func_2069
    ldr x0, [sp], #16
    bl _cons
blk_end_2063:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2061_2062:
    // Closure for func_2061
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
    adr x1, func_2061
    ldr x0, [sp], #16
    bl _cons
blk_end_2055:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2053_2054:
    // Closure for func_2053
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
    adr x1, func_2053
    ldr x0, [sp], #16
    bl _cons
blk_end_2047:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2045_2046:
    // Closure for func_2045
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
    adr x1, func_2045
    ldr x0, [sp], #16
    bl _cons
blk_end_2036:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2034_2035:
    // Closure for func_2034
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
    adr x1, func_2034
    ldr x0, [sp], #16
    bl _cons
blk_end_2028:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2026_2027:
    // Closure for func_2026
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
    adr x1, func_2026
    ldr x0, [sp], #16
    bl _cons
blk_end_2020:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2018_2019:
    // Closure for func_2018
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
    adr x1, func_2018
    ldr x0, [sp], #16
    bl _cons
blk_end_2009:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2007_2008:
    // Closure for func_2007
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
    adr x1, func_2007
    ldr x0, [sp], #16
    bl _cons
blk_end_1992:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1990_1991:
    // Closure for func_1990
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
    adr x1, func_1990
    ldr x0, [sp], #16
    bl _cons
blk_end_1978:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1976_1977:
    // Closure for func_1976
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
    adr x1, func_1976
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1974_1975:
    // Closure for func_1974
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_1974
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1972_1973:
    // Closure for func_1972
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1972
    ldr x0, [sp], #16
    bl _cons
    b cond_end_1968
cond_false_1967:
    adr x0, sign_id
cond_end_1968:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_binop
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2157
    tst x1, #1
    b.eq do_concat_2157
do_apply_2156:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2158
do_concat_2157:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2158:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2154
    b after_func_2159_2160
func_2159:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2161_2162
func_2161:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2163_2164
func_2163:
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
    b after_func_2165_2166
func_2165:
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
    b.eq or_right_2168
    b or_end_2169
or_right_2168:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2171
    tst x1, #1
    b.eq do_concat_2171
do_apply_2170:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2172
do_concat_2171:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2172:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2174
    tst x1, #1
    b.eq do_concat_2174
do_apply_2173:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2175
do_concat_2174:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2175:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2177
    tst x1, #1
    b.eq do_concat_2177
do_apply_2176:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2178
do_concat_2177:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2178:
or_end_2169:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2167
    b after_func_2179_2180
func_2179:
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
    b.eq or_right_2182
    b or_end_2183
or_right_2182:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2185
    tst x1, #1
    b.eq do_concat_2185
do_apply_2184:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2186
do_concat_2185:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2186:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2188
    tst x1, #1
    b.eq do_concat_2188
do_apply_2187:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2189
do_concat_2188:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2189:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2191
    tst x1, #1
    b.eq do_concat_2191
do_apply_2190:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2192
do_concat_2191:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2192:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2194
    tst x1, #1
    b.eq do_concat_2194
do_apply_2193:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2195
do_concat_2194:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2195:
or_end_2183:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2181
    b after_func_2196_2197
func_2196:
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
    b.eq or_right_2199
    b or_end_2200
or_right_2199:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2202
    tst x1, #1
    b.eq do_concat_2202
do_apply_2201:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2203
do_concat_2202:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2203:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2205
    tst x1, #1
    b.eq do_concat_2205
do_apply_2204:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2206
do_concat_2205:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2206:
or_end_2200:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2198
    b after_func_2207_2208
func_2207:
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
    b.eq or_right_2210
    b or_end_2211
or_right_2210:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2213
    tst x1, #1
    b.eq do_concat_2213
do_apply_2212:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2214
do_concat_2213:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2214:
or_end_2211:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2209
    b after_func_2215_2216
func_2215:
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
    b.eq or_right_2218
    b or_end_2219
or_right_2218:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2221
    tst x1, #1
    b.eq do_concat_2221
do_apply_2220:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2222
do_concat_2221:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2222:
or_end_2219:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2217
    b after_func_2223_2224
func_2223:
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
    b.eq or_right_2226
    b or_end_2227
or_right_2226:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2229
    tst x1, #1
    b.eq do_concat_2229
do_apply_2228:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2230
do_concat_2229:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2230:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2232
    tst x1, #1
    b.eq do_concat_2232
do_apply_2231:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2233
do_concat_2232:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2233:
or_end_2227:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2225
    b after_func_2234_2235
func_2234:
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
    b.eq or_right_2237
    b or_end_2238
or_right_2237:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2240
    tst x1, #1
    b.eq do_concat_2240
do_apply_2239:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2241
do_concat_2240:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2241:
or_end_2238:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2236
    b after_func_2242_2243
func_2242:
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
    b.eq or_right_2245
    b or_end_2246
or_right_2245:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2248
    tst x1, #1
    b.eq do_concat_2248
do_apply_2247:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2249
do_concat_2248:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2249:
or_end_2246:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2244
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
    b.ne blk_end_2250
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_2250:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2252
    tst x1, #1
    b.eq do_concat_2252
do_apply_2251:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2253
do_concat_2252:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2253:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2255
    tst x1, #1
    b.eq do_concat_2255
do_apply_2254:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2256
do_concat_2255:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2256:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2258
    tst x1, #1
    b.eq do_concat_2258
do_apply_2257:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2259
do_concat_2258:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2259:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2261
    tst x1, #1
    b.eq do_concat_2261
do_apply_2260:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2262
do_concat_2261:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2262:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_2244:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2242_2243:
    // Closure for func_2242
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
    adr x1, func_2242
    ldr x0, [sp], #16
    bl _cons
blk_end_2236:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2234_2235:
    // Closure for func_2234
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
    adr x1, func_2234
    ldr x0, [sp], #16
    bl _cons
blk_end_2225:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2223_2224:
    // Closure for func_2223
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
    adr x1, func_2223
    ldr x0, [sp], #16
    bl _cons
blk_end_2217:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2215_2216:
    // Closure for func_2215
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
    adr x1, func_2215
    ldr x0, [sp], #16
    bl _cons
blk_end_2209:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2207_2208:
    // Closure for func_2207
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
    adr x1, func_2207
    ldr x0, [sp], #16
    bl _cons
blk_end_2198:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2196_2197:
    // Closure for func_2196
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
    adr x1, func_2196
    ldr x0, [sp], #16
    bl _cons
blk_end_2181:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2179_2180:
    // Closure for func_2179
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
    adr x1, func_2179
    ldr x0, [sp], #16
    bl _cons
blk_end_2167:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2165_2166:
    // Closure for func_2165
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
    adr x1, func_2165
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2163_2164:
    // Closure for func_2163
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
    adr x1, func_2163
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2161_2162:
    // Closure for func_2161
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2161
    ldr x0, [sp], #16
    bl _cons
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
    b cond_end_2155
cond_false_2154:
    adr x0, sign_id
cond_end_2155:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_cmp
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2266
    tst x1, #1
    b.eq do_concat_2266
do_apply_2265:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2267
do_concat_2266:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2267:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2263
    b after_func_2268_2269
func_2268:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2270_2271
func_2270:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2272_2273
func_2272:
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
    b after_func_2274_2275
func_2274:
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
    b.eq or_right_2277
    b or_end_2278
or_right_2277:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2280
    tst x1, #1
    b.eq do_concat_2280
do_apply_2279:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2281
do_concat_2280:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2281:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2283
    tst x1, #1
    b.eq do_concat_2283
do_apply_2282:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2284
do_concat_2283:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2284:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2286
    tst x1, #1
    b.eq do_concat_2286
do_apply_2285:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2287
do_concat_2286:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2287:
or_end_2278:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2276
    b after_func_2288_2289
func_2288:
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
    b.eq or_right_2291
    b or_end_2292
or_right_2291:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2294
    tst x1, #1
    b.eq do_concat_2294
do_apply_2293:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2295
do_concat_2294:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2295:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2297
    tst x1, #1
    b.eq do_concat_2297
do_apply_2296:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2298
do_concat_2297:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2298:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2300
    tst x1, #1
    b.eq do_concat_2300
do_apply_2299:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2301
do_concat_2300:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2301:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2303
    tst x1, #1
    b.eq do_concat_2303
do_apply_2302:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2304
do_concat_2303:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2304:
or_end_2292:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2290
    b after_func_2305_2306
func_2305:
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
    b.eq or_right_2308
    b or_end_2309
or_right_2308:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2311
    tst x1, #1
    b.eq do_concat_2311
do_apply_2310:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2312
do_concat_2311:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2312:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2314
    tst x1, #1
    b.eq do_concat_2314
do_apply_2313:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2315
do_concat_2314:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2315:
or_end_2309:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2307
    b after_func_2316_2317
func_2316:
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
    b.eq or_right_2319
    b or_end_2320
or_right_2319:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2322
    tst x1, #1
    b.eq do_concat_2322
do_apply_2321:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2323
do_concat_2322:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2323:
or_end_2320:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2318
    b after_func_2324_2325
func_2324:
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
    b.eq or_right_2327
    b or_end_2328
or_right_2327:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2330
    tst x1, #1
    b.eq do_concat_2330
do_apply_2329:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2331
do_concat_2330:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2331:
or_end_2328:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2326
    b after_func_2332_2333
func_2332:
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
    b.eq or_right_2335
    b or_end_2336
or_right_2335:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2338
    tst x1, #1
    b.eq do_concat_2338
do_apply_2337:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2339
do_concat_2338:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2339:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2341
    tst x1, #1
    b.eq do_concat_2341
do_apply_2340:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2342
do_concat_2341:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2342:
or_end_2336:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2334
    b after_func_2343_2344
func_2343:
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
    b.eq or_right_2346
    b or_end_2347
or_right_2346:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2349
    tst x1, #1
    b.eq do_concat_2349
do_apply_2348:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2350
do_concat_2349:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2350:
or_end_2347:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2345
    b after_func_2351_2352
func_2351:
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
    b.eq or_right_2354
    b or_end_2355
or_right_2354:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2357
    tst x1, #1
    b.eq do_concat_2357
do_apply_2356:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2358
do_concat_2357:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2358:
or_end_2355:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2353
    b after_func_2359_2360
func_2359:
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
    b.eq or_right_2362
    b or_end_2363
or_right_2362:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2365
    tst x1, #1
    b.eq do_concat_2365
do_apply_2364:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2366
do_concat_2365:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2366:
    str x0, [sp, #-16]!
    adr x0, str_77
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2368
    tst x1, #1
    b.eq do_concat_2368
do_apply_2367:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2369
do_concat_2368:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2369:
or_end_2363:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2361
    b after_func_2370_2371
func_2370:
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
    b.eq or_right_2373
    b or_end_2374
or_right_2373:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2376
    tst x1, #1
    b.eq do_concat_2376
do_apply_2375:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2377
do_concat_2376:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2377:
or_end_2374:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2372
    b after_func_2378_2379
func_2378:
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
    b.eq or_right_2381
    b or_end_2382
or_right_2381:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2384
    tst x1, #1
    b.eq do_concat_2384
do_apply_2383:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2385
do_concat_2384:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2385:
    str x0, [sp, #-16]!
    adr x0, str_78
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2387
    tst x1, #1
    b.eq do_concat_2387
do_apply_2386:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2388
do_concat_2387:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2388:
or_end_2382:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2380
    b after_func_2389_2390
func_2389:
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
    b.eq or_right_2392
    b or_end_2393
or_right_2392:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2395
    tst x1, #1
    b.eq do_concat_2395
do_apply_2394:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2396
do_concat_2395:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2396:
or_end_2393:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2391
    b after_func_2397_2398
func_2397:
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
    b.eq or_right_2400
    b or_end_2401
or_right_2400:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2403
    tst x1, #1
    b.eq do_concat_2403
do_apply_2402:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2404
do_concat_2403:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2404:
or_end_2401:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2399
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
    b.ne blk_end_2405
    adr x0, str_79
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2405
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_80
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2407
    tst x1, #1
    b.eq do_concat_2407
do_apply_2406:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2408
do_concat_2407:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2408:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2410
    tst x1, #1
    b.eq do_concat_2410
do_apply_2409:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2411
do_concat_2410:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2411:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    mov x0, #32
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2413
    tst x1, #1
    b.eq do_concat_2413
do_apply_2412:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2414
do_concat_2413:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2414:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2416
    tst x1, #1
    b.eq do_concat_2416
do_apply_2415:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2417
do_concat_2416:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2417:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2419
    tst x1, #1
    b.eq do_concat_2419
do_apply_2418:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2420
do_concat_2419:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2420:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2422
    tst x1, #1
    b.eq do_concat_2422
do_apply_2421:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2423
do_concat_2422:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2423:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2425
    tst x1, #1
    b.eq do_concat_2425
do_apply_2424:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2426
do_concat_2425:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2426:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2428
    tst x1, #1
    b.eq do_concat_2428
do_apply_2427:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2429
do_concat_2428:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2429:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2405
    adr x0, str_44
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2405
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_20
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2431
    tst x1, #1
    b.eq do_concat_2431
do_apply_2430:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2432
do_concat_2431:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2432:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2434
    tst x1, #1
    b.eq do_concat_2434
do_apply_2433:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2435
do_concat_2434:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2435:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2437
    tst x1, #1
    b.eq do_concat_2437
do_apply_2436:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2438
do_concat_2437:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2438:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2440
    tst x1, #1
    b.eq do_concat_2440
do_apply_2439:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2441
do_concat_2440:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2441:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2405
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2443
    tst x1, #1
    b.eq do_concat_2443
do_apply_2442:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2444
do_concat_2443:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2444:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2446
    tst x1, #1
    b.eq do_concat_2446
do_apply_2445:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2447
do_concat_2446:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2447:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2405
    b after_func_2448_2449
func_2448:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2450_2451
func_2450:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, str_23
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_2452
    b or_end_2453
or_right_2452:
    mov x0, #0
or_end_2453:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2450_2451:
    // Closure for func_2450
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2450
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2448_2449:
    // Closure for func_2448
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2448
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2455
    tst x1, #1
    b.eq do_concat_2455
do_apply_2454:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2456
do_concat_2455:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2456:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2458
    tst x1, #1
    b.eq do_concat_2458
do_apply_2457:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2459
do_concat_2458:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2459:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2461
    tst x1, #1
    b.eq do_concat_2461
do_apply_2460:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2462
do_concat_2461:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2462:
blk_end_2405:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2464
    tst x1, #1
    b.eq do_concat_2464
do_apply_2463:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2465
do_concat_2464:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2465:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2467
    tst x1, #1
    b.eq do_concat_2467
do_apply_2466:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2468
do_concat_2467:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2468:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2470
    tst x1, #1
    b.eq do_concat_2470
do_apply_2469:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2471
do_concat_2470:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2471:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2473
    tst x1, #1
    b.eq do_concat_2473
do_apply_2472:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2474
do_concat_2473:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2474:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-144]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_2399:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2397_2398:
    // Closure for func_2397
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
    adr x1, func_2397
    ldr x0, [sp], #16
    bl _cons
blk_end_2391:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2389_2390:
    // Closure for func_2389
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
    adr x1, func_2389
    ldr x0, [sp], #16
    bl _cons
blk_end_2380:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2378_2379:
    // Closure for func_2378
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
    adr x1, func_2378
    ldr x0, [sp], #16
    bl _cons
blk_end_2372:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2370_2371:
    // Closure for func_2370
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
    adr x1, func_2370
    ldr x0, [sp], #16
    bl _cons
blk_end_2361:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2359_2360:
    // Closure for func_2359
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
    adr x1, func_2359
    ldr x0, [sp], #16
    bl _cons
blk_end_2353:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2351_2352:
    // Closure for func_2351
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
    adr x1, func_2351
    ldr x0, [sp], #16
    bl _cons
blk_end_2345:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2343_2344:
    // Closure for func_2343
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
    adr x1, func_2343
    ldr x0, [sp], #16
    bl _cons
blk_end_2334:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2332_2333:
    // Closure for func_2332
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
    adr x1, func_2332
    ldr x0, [sp], #16
    bl _cons
blk_end_2326:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2324_2325:
    // Closure for func_2324
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
    adr x1, func_2324
    ldr x0, [sp], #16
    bl _cons
blk_end_2318:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2316_2317:
    // Closure for func_2316
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
    adr x1, func_2316
    ldr x0, [sp], #16
    bl _cons
blk_end_2307:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2305_2306:
    // Closure for func_2305
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
    adr x1, func_2305
    ldr x0, [sp], #16
    bl _cons
blk_end_2290:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2288_2289:
    // Closure for func_2288
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
    adr x1, func_2288
    ldr x0, [sp], #16
    bl _cons
blk_end_2276:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2274_2275:
    // Closure for func_2274
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
    adr x1, func_2274
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2272_2273:
    // Closure for func_2272
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
    adr x1, func_2272
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2270_2271:
    // Closure for func_2270
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2270
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2268_2269:
    // Closure for func_2268
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2268
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2264
cond_false_2263:
    adr x0, sign_id
cond_end_2264:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_logic_or
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2478
    tst x1, #1
    b.eq do_concat_2478
do_apply_2477:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2479
do_concat_2478:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2479:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2475
    b after_func_2480_2481
func_2480:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2482_2483
func_2482:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2484_2485
func_2484:
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
    b.eq or_right_2487
    b or_end_2488
or_right_2487:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2490
    tst x1, #1
    b.eq do_concat_2490
do_apply_2489:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2491
do_concat_2490:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2491:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2493
    tst x1, #1
    b.eq do_concat_2493
do_apply_2492:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2494
do_concat_2493:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2494:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2496
    tst x1, #1
    b.eq do_concat_2496
do_apply_2495:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2497
do_concat_2496:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2497:
or_end_2488:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2486
    b after_func_2498_2499
func_2498:
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
    b.eq or_right_2501
    b or_end_2502
or_right_2501:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2504
    tst x1, #1
    b.eq do_concat_2504
do_apply_2503:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2505
do_concat_2504:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2505:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2507
    tst x1, #1
    b.eq do_concat_2507
do_apply_2506:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2508
do_concat_2507:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2508:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2510
    tst x1, #1
    b.eq do_concat_2510
do_apply_2509:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2511
do_concat_2510:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2511:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2513
    tst x1, #1
    b.eq do_concat_2513
do_apply_2512:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2514
do_concat_2513:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2514:
or_end_2502:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2500
    b after_func_2515_2516
func_2515:
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
    b.eq or_right_2518
    b or_end_2519
or_right_2518:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2521
    tst x1, #1
    b.eq do_concat_2521
do_apply_2520:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2522
do_concat_2521:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2522:
    str x0, [sp, #-16]!
    adr x0, str_81
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2524
    tst x1, #1
    b.eq do_concat_2524
do_apply_2523:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2525
do_concat_2524:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2525:
or_end_2519:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2517
    b after_func_2526_2527
func_2526:
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
    b.eq or_right_2529
    b or_end_2530
or_right_2529:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2532
    tst x1, #1
    b.eq do_concat_2532
do_apply_2531:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2533
do_concat_2532:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2533:
or_end_2530:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2528
    b after_func_2534_2535
func_2534:
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
    b.eq or_right_2537
    b or_end_2538
or_right_2537:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2540
    tst x1, #1
    b.eq do_concat_2540
do_apply_2539:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2541
do_concat_2540:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2541:
    str x0, [sp, #-16]!
    adr x0, str_82
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2543
    tst x1, #1
    b.eq do_concat_2543
do_apply_2542:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2544
do_concat_2543:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2544:
or_end_2538:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2536
    b after_func_2545_2546
func_2545:
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
    b.eq or_right_2548
    b or_end_2549
or_right_2548:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2551
    tst x1, #1
    b.eq do_concat_2551
do_apply_2550:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2552
do_concat_2551:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2552:
or_end_2549:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2547
    b after_func_2553_2554
func_2553:
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
    b.eq or_right_2556
    b or_end_2557
or_right_2556:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2559
    tst x1, #1
    b.eq do_concat_2559
do_apply_2558:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2560
do_concat_2559:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2560:
or_end_2557:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2555
    b after_func_2561_2562
func_2561:
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
    b.eq or_right_2564
    b or_end_2565
or_right_2564:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2567
    tst x1, #1
    b.eq do_concat_2567
do_apply_2566:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2568
do_concat_2567:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2568:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2570
    tst x1, #1
    b.eq do_concat_2570
do_apply_2569:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2571
do_concat_2570:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2571:
or_end_2565:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2563
    b after_func_2572_2573
func_2572:
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
    b.eq or_right_2575
    b or_end_2576
or_right_2575:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2578
    tst x1, #1
    b.eq do_concat_2578
do_apply_2577:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2579
do_concat_2578:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2579:
or_end_2576:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2574
    b after_func_2580_2581
func_2580:
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
    b.eq or_right_2583
    b or_end_2584
or_right_2583:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2586
    tst x1, #1
    b.eq do_concat_2586
do_apply_2585:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2587
do_concat_2586:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2587:
or_end_2584:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2582
    b after_func_2588_2589
func_2588:
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
    b.eq or_right_2591
    b or_end_2592
or_right_2591:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2594
    tst x1, #1
    b.eq do_concat_2594
do_apply_2593:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2595
do_concat_2594:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2595:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2597
    tst x1, #1
    b.eq do_concat_2597
do_apply_2596:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2598
do_concat_2597:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2598:
or_end_2592:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2590
    b after_func_2599_2600
func_2599:
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
    b.eq or_right_2602
    b or_end_2603
or_right_2602:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2605
    tst x1, #1
    b.eq do_concat_2605
do_apply_2604:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2606
do_concat_2605:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2606:
or_end_2603:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2601
    b after_func_2607_2608
func_2607:
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
    b.eq or_right_2610
    b or_end_2611
or_right_2610:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2613
    tst x1, #1
    b.eq do_concat_2613
do_apply_2612:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2614
do_concat_2613:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2614:
or_end_2611:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2609
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_42
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_43
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2615
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_15
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2617
    tst x1, #1
    b.eq do_concat_2617
do_apply_2616:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2618
do_concat_2617:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2618:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2620
    tst x1, #1
    b.eq do_concat_2620
do_apply_2619:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2621
do_concat_2620:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2621:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2623
    tst x1, #1
    b.eq do_concat_2623
do_apply_2622:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2624
do_concat_2623:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2624:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2626
    tst x1, #1
    b.eq do_concat_2626
do_apply_2625:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2627
do_concat_2626:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2627:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2615
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_20
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2629
    tst x1, #1
    b.eq do_concat_2629
do_apply_2628:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2630
do_concat_2629:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2630:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2632
    tst x1, #1
    b.eq do_concat_2632
do_apply_2631:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2633
do_concat_2632:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2633:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2635
    tst x1, #1
    b.eq do_concat_2635
do_apply_2634:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2636
do_concat_2635:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2636:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2638
    tst x1, #1
    b.eq do_concat_2638
do_apply_2637:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2639
do_concat_2638:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2639:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2615
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2641
    tst x1, #1
    b.eq do_concat_2641
do_apply_2640:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2642
do_concat_2641:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2642:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2644
    tst x1, #1
    b.eq do_concat_2644
do_apply_2643:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2645
do_concat_2644:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2645:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2615
    ldr x0, [x29, #-112]
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-96]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2647
    tst x1, #1
    b.eq do_concat_2647
do_apply_2646:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2648
do_concat_2647:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2648:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2650
    tst x1, #1
    b.eq do_concat_2650
do_apply_2649:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2651
do_concat_2650:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2651:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _concat
blk_end_2615:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2653
    tst x1, #1
    b.eq do_concat_2653
do_apply_2652:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2654
do_concat_2653:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2654:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2656
    tst x1, #1
    b.eq do_concat_2656
do_apply_2655:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2657
do_concat_2656:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2657:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_2609:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2607_2608:
    // Closure for func_2607
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
    adr x1, func_2607
    ldr x0, [sp], #16
    bl _cons
blk_end_2601:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2599_2600:
    // Closure for func_2599
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
    adr x1, func_2599
    ldr x0, [sp], #16
    bl _cons
blk_end_2590:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2588_2589:
    // Closure for func_2588
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
    adr x1, func_2588
    ldr x0, [sp], #16
    bl _cons
blk_end_2582:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2580_2581:
    // Closure for func_2580
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
    adr x1, func_2580
    ldr x0, [sp], #16
    bl _cons
blk_end_2574:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2572_2573:
    // Closure for func_2572
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
    adr x1, func_2572
    ldr x0, [sp], #16
    bl _cons
blk_end_2563:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2561_2562:
    // Closure for func_2561
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
    adr x1, func_2561
    ldr x0, [sp], #16
    bl _cons
blk_end_2555:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2553_2554:
    // Closure for func_2553
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
    adr x1, func_2553
    ldr x0, [sp], #16
    bl _cons
blk_end_2547:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2545_2546:
    // Closure for func_2545
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
    adr x1, func_2545
    ldr x0, [sp], #16
    bl _cons
blk_end_2536:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2534_2535:
    // Closure for func_2534
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
    adr x1, func_2534
    ldr x0, [sp], #16
    bl _cons
blk_end_2528:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2526_2527:
    // Closure for func_2526
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
    adr x1, func_2526
    ldr x0, [sp], #16
    bl _cons
blk_end_2517:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2515_2516:
    // Closure for func_2515
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
    adr x1, func_2515
    ldr x0, [sp], #16
    bl _cons
blk_end_2500:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2498_2499:
    // Closure for func_2498
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
    adr x1, func_2498
    ldr x0, [sp], #16
    bl _cons
blk_end_2486:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2484_2485:
    // Closure for func_2484
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
    adr x1, func_2484
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2482_2483:
    // Closure for func_2482
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2482
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2480_2481:
    // Closure for func_2480
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2480
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2476
cond_false_2475:
    adr x0, sign_id
cond_end_2476:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_logic_and
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2661
    tst x1, #1
    b.eq do_concat_2661
do_apply_2660:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2662
do_concat_2661:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2662:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2658
    b after_func_2663_2664
func_2663:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2665_2666
func_2665:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2667_2668
func_2667:
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
    b.eq or_right_2670
    b or_end_2671
or_right_2670:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2673
    tst x1, #1
    b.eq do_concat_2673
do_apply_2672:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2674
do_concat_2673:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2674:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2676
    tst x1, #1
    b.eq do_concat_2676
do_apply_2675:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2677
do_concat_2676:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2677:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2679
    tst x1, #1
    b.eq do_concat_2679
do_apply_2678:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2680
do_concat_2679:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2680:
or_end_2671:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2669
    b after_func_2681_2682
func_2681:
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
    b.eq or_right_2684
    b or_end_2685
or_right_2684:
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2687
    tst x1, #1
    b.eq do_concat_2687
do_apply_2686:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2688
do_concat_2687:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2688:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2690
    tst x1, #1
    b.eq do_concat_2690
do_apply_2689:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2691
do_concat_2690:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2691:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2693
    tst x1, #1
    b.eq do_concat_2693
do_apply_2692:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2694
do_concat_2693:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2694:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2696
    tst x1, #1
    b.eq do_concat_2696
do_apply_2695:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2697
do_concat_2696:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2697:
or_end_2685:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2683
    b after_func_2698_2699
func_2698:
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
    b.eq or_right_2701
    b or_end_2702
or_right_2701:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2704
    tst x1, #1
    b.eq do_concat_2704
do_apply_2703:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2705
do_concat_2704:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2705:
    str x0, [sp, #-16]!
    adr x0, str_83
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2707
    tst x1, #1
    b.eq do_concat_2707
do_apply_2706:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2708
do_concat_2707:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2708:
or_end_2702:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2700
    b after_func_2709_2710
func_2709:
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
    b.eq or_right_2712
    b or_end_2713
or_right_2712:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2715
    tst x1, #1
    b.eq do_concat_2715
do_apply_2714:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2716
do_concat_2715:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2716:
or_end_2713:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2711
    b after_func_2717_2718
func_2717:
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
    b.eq or_right_2720
    b or_end_2721
or_right_2720:
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2723
    tst x1, #1
    b.eq do_concat_2723
do_apply_2722:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2724
do_concat_2723:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2724:
    str x0, [sp, #-16]!
    adr x0, str_84
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2726
    tst x1, #1
    b.eq do_concat_2726
do_apply_2725:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2727
do_concat_2726:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2727:
or_end_2721:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2719
    b after_func_2728_2729
func_2728:
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
    b.eq or_right_2731
    b or_end_2732
or_right_2731:
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2734
    tst x1, #1
    b.eq do_concat_2734
do_apply_2733:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2735
do_concat_2734:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2735:
or_end_2732:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2730
    b after_func_2736_2737
func_2736:
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
    b.eq or_right_2739
    b or_end_2740
or_right_2739:
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2742
    tst x1, #1
    b.eq do_concat_2742
do_apply_2741:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2743
do_concat_2742:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2743:
or_end_2740:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2738
    b after_func_2744_2745
func_2744:
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
    b.eq or_right_2747
    b or_end_2748
or_right_2747:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2750
    tst x1, #1
    b.eq do_concat_2750
do_apply_2749:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2751
do_concat_2750:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2751:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2753
    tst x1, #1
    b.eq do_concat_2753
do_apply_2752:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2754
do_concat_2753:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2754:
or_end_2748:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2746
    b after_func_2755_2756
func_2755:
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
    b.eq or_right_2758
    b or_end_2759
or_right_2758:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2761
    tst x1, #1
    b.eq do_concat_2761
do_apply_2760:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2762
do_concat_2761:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2762:
or_end_2759:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2757
    b after_func_2763_2764
func_2763:
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
    b.eq or_right_2766
    b or_end_2767
or_right_2766:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2769
    tst x1, #1
    b.eq do_concat_2769
do_apply_2768:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2770
do_concat_2769:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2770:
or_end_2767:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2765
    b after_func_2771_2772
func_2771:
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
    b.eq or_right_2774
    b or_end_2775
or_right_2774:
    adr x0, compile_node
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2777
    tst x1, #1
    b.eq do_concat_2777
do_apply_2776:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2778
do_concat_2777:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2778:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2780
    tst x1, #1
    b.eq do_concat_2780
do_apply_2779:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2781
do_concat_2780:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2781:
or_end_2775:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2773
    b after_func_2782_2783
func_2782:
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
    b.eq or_right_2785
    b or_end_2786
or_right_2785:
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2788
    tst x1, #1
    b.eq do_concat_2788
do_apply_2787:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2789
do_concat_2788:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2789:
or_end_2786:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2784
    b after_func_2790_2791
func_2790:
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
    b.eq or_right_2793
    b or_end_2794
or_right_2793:
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2796
    tst x1, #1
    b.eq do_concat_2796
do_apply_2795:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2797
do_concat_2796:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2797:
or_end_2794:
    str x0, [sp, #-16]!
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2792
    ldr x0, [x29, #-64]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_42
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_43
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2798
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_15
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2800
    tst x1, #1
    b.eq do_concat_2800
do_apply_2799:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2801
do_concat_2800:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2801:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2803
    tst x1, #1
    b.eq do_concat_2803
do_apply_2802:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2804
do_concat_2803:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2804:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2806
    tst x1, #1
    b.eq do_concat_2806
do_apply_2805:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2807
do_concat_2806:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2807:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2809
    tst x1, #1
    b.eq do_concat_2809
do_apply_2808:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2810
do_concat_2809:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2810:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2798
    ldr x0, [x29, #-96]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_20
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2812
    tst x1, #1
    b.eq do_concat_2812
do_apply_2811:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2813
do_concat_2812:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2813:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2815
    tst x1, #1
    b.eq do_concat_2815
do_apply_2814:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2816
do_concat_2815:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2816:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2818
    tst x1, #1
    b.eq do_concat_2818
do_apply_2817:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2819
do_concat_2818:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2819:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2821
    tst x1, #1
    b.eq do_concat_2821
do_apply_2820:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2822
do_concat_2821:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2822:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-80]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2825
    tst x1, #1
    b.eq do_concat_2825
do_apply_2824:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2826
do_concat_2825:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2826:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2828
    tst x1, #1
    b.eq do_concat_2828
do_apply_2827:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2829
do_concat_2828:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2829:
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2823
    adr x0, str_35
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2823
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-112]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2831
    tst x1, #1
    b.eq do_concat_2831
do_apply_2830:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2832
do_concat_2831:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2832:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2834
    tst x1, #1
    b.eq do_concat_2834
do_apply_2833:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2835
do_concat_2834:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2835:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
blk_end_2823:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2837
    tst x1, #1
    b.eq do_concat_2837
do_apply_2836:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2838
do_concat_2837:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2838:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2840
    tst x1, #1
    b.eq do_concat_2840
do_apply_2839:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2841
do_concat_2840:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2841:
blk_end_2798:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2843
    tst x1, #1
    b.eq do_concat_2843
do_apply_2842:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2844
do_concat_2843:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2844:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2846
    tst x1, #1
    b.eq do_concat_2846
do_apply_2845:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2847
do_concat_2846:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2847:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-128]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
blk_end_2792:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2790_2791:
    // Closure for func_2790
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
    adr x1, func_2790
    ldr x0, [sp], #16
    bl _cons
blk_end_2784:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2782_2783:
    // Closure for func_2782
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
    adr x1, func_2782
    ldr x0, [sp], #16
    bl _cons
blk_end_2773:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2771_2772:
    // Closure for func_2771
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
    adr x1, func_2771
    ldr x0, [sp], #16
    bl _cons
blk_end_2765:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2763_2764:
    // Closure for func_2763
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
    adr x1, func_2763
    ldr x0, [sp], #16
    bl _cons
blk_end_2757:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2755_2756:
    // Closure for func_2755
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
    adr x1, func_2755
    ldr x0, [sp], #16
    bl _cons
blk_end_2746:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2744_2745:
    // Closure for func_2744
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
    adr x1, func_2744
    ldr x0, [sp], #16
    bl _cons
blk_end_2738:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2736_2737:
    // Closure for func_2736
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
    adr x1, func_2736
    ldr x0, [sp], #16
    bl _cons
blk_end_2730:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2728_2729:
    // Closure for func_2728
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
    adr x1, func_2728
    ldr x0, [sp], #16
    bl _cons
blk_end_2719:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2717_2718:
    // Closure for func_2717
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
    adr x1, func_2717
    ldr x0, [sp], #16
    bl _cons
blk_end_2711:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2709_2710:
    // Closure for func_2709
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
    adr x1, func_2709
    ldr x0, [sp], #16
    bl _cons
blk_end_2700:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2698_2699:
    // Closure for func_2698
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
    adr x1, func_2698
    ldr x0, [sp], #16
    bl _cons
blk_end_2683:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2681_2682:
    // Closure for func_2681
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
    adr x1, func_2681
    ldr x0, [sp], #16
    bl _cons
blk_end_2669:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2667_2668:
    // Closure for func_2667
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
    adr x1, func_2667
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2665_2666:
    // Closure for func_2665
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2665
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2663_2664:
    // Closure for func_2663
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2663
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2659
cond_false_2658:
    adr x0, sign_id
cond_end_2659:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_block
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2851
    tst x1, #1
    b.eq do_concat_2851
do_apply_2850:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2852
do_concat_2851:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2852:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2848
    b after_func_2853_2854
func_2853:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2855_2856
func_2855:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2858_2859
func_2858:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2858_2859:
    // Closure for func_2858
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2858
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, stmts
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2863
    adr x0, sign_id
    b cmp_end_2864
cmp_true_2863:
cmp_end_2864:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2861
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_35
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
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2866
    tst x1, #1
    b.eq do_concat_2866
do_apply_2865:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2867
do_concat_2866:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2867:
    b cond_end_2862
cond_false_2861:
    adr x0, sign_id
cond_end_2862:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2860
    b after_func_2868_2869
func_2868:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2868_2869:
    // Closure for func_2868
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2868
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2871_2872
func_2871:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2871_2872:
    // Closure for func_2871
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2871
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2874_2875
func_2874:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2876_2877
func_2876:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2876_2877:
    // Closure for func_2876
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2876
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2874_2875:
    // Closure for func_2874
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2874
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, asm_stmts
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2879
    tst x1, #1
    b.eq do_concat_2879
do_apply_2878:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2880
do_concat_2879:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2880:
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2882
    tst x1, #1
    b.eq do_concat_2882
do_apply_2881:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2883
do_concat_2882:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2883:
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0
    ldr x0, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, ctx_stmts
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2885
    tst x1, #1
    b.eq do_concat_2885
do_apply_2884:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2886
do_concat_2885:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2886:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2873
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2888
    tst x1, #1
    b.eq do_concat_2888
do_apply_2887:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2889
do_concat_2888:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2889:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2891
    tst x1, #1
    b.eq do_concat_2891
do_apply_2890:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2892
do_concat_2891:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2892:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2894
    tst x1, #1
    b.eq do_concat_2894
do_apply_2893:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2895
do_concat_2894:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2895:
blk_end_2873:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2897
    tst x1, #1
    b.eq do_concat_2897
do_apply_2896:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2898
do_concat_2897:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2898:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2870
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    adr x0, stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2900
    tst x1, #1
    b.eq do_concat_2900
do_apply_2899:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2901
do_concat_2900:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2901:
    str x0, [sp, #-16]!
    adr x0, lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2903
    tst x1, #1
    b.eq do_concat_2903
do_apply_2902:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2904
do_concat_2903:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2904:
    str x0, [sp, #-16]!
    adr x0, ctx_from_lbl
    str x0, [sp, #-16]!
    adr x0, res_lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2906
    tst x1, #1
    b.eq do_concat_2906
do_apply_2905:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2907
do_concat_2906:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2907:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2909
    tst x1, #1
    b.eq do_concat_2909
do_apply_2908:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2910
do_concat_2909:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2910:
blk_end_2870:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2912
    tst x1, #1
    b.eq do_concat_2912
do_apply_2911:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2913
do_concat_2912:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2913:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2860
    adr x0, new_label
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2915
    tst x1, #1
    b.eq do_concat_2915
do_apply_2914:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2916
do_concat_2915:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2916:
    str x0, [sp, #-16]!
    adr x0, str_85
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2918
    tst x1, #1
    b.eq do_concat_2918
do_apply_2917:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2919
do_concat_2918:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2919:
blk_end_2860:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2921
    tst x1, #1
    b.eq do_concat_2921
do_apply_2920:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2922
do_concat_2921:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2922:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2857
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2924
    tst x1, #1
    b.eq do_concat_2924
do_apply_2923:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2925
do_concat_2924:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2925:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2927
    tst x1, #1
    b.eq do_concat_2927
do_apply_2926:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2928
do_concat_2927:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2928:
blk_end_2857:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2855_2856:
    // Closure for func_2855
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2855
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2853_2854:
    // Closure for func_2853
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2853
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2849
cond_false_2848:
    adr x0, sign_id
cond_end_2849:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, compile_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2932
    tst x1, #1
    b.eq do_concat_2932
do_apply_2931:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2933
do_concat_2932:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2933:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2929
    b after_func_2934_2935
func_2934:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2936_2937
func_2936:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x9, [x29, #-16] // Reload Env
    ldr x10, [x9] // Load Val
    str x10, [sp, #-16]! // Push Val
    ldr x9, [x9, #8] // Next
    b after_func_2938_2939
func_2938:
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
    b after_func_2941_2942
func_2941:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2941_2942:
    // Closure for func_2941
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2941
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2944_2945
func_2944:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2944_2945:
    // Closure for func_2944
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2944
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tail_stmts
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_2949
    adr x0, sign_id
    b cmp_end_2950
cmp_true_2949:
cmp_end_2950:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_2947
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, str_86
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2951
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, head_stmt
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2953
    tst x1, #1
    b.eq do_concat_2953
do_apply_2952:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2954
do_concat_2953:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2954:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2956
    tst x1, #1
    b.eq do_concat_2956
do_apply_2955:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2957
do_concat_2956:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2957:
blk_end_2951:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2959
    tst x1, #1
    b.eq do_concat_2959
do_apply_2958:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2960
do_concat_2959:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2960:
    b cond_end_2948
cond_false_2947:
    adr x0, sign_id
cond_end_2948:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2946
    adr x0, str_87
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2946
    b after_func_2961_2962
func_2961:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2961_2962:
    // Closure for func_2961
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2961
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2964_2965
func_2964:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2966_2967
func_2966:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2966_2967:
    // Closure for func_2966
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2966
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2964_2965:
    // Closure for func_2964
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2964
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2969_2970
func_2969:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2969_2970:
    // Closure for func_2969
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2969
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    b after_func_2972_2973
func_2972:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_2974_2975
func_2974:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2974_2975:
    // Closure for func_2974
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2974
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2972_2973:
    // Closure for func_2972
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2972
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, asm_head
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _concat
    str x0, [sp, #-16]!
    adr x0, str_42
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, str_43
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    adr x0, str_88
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2977
    tst x1, #1
    b.eq do_concat_2977
do_apply_2976:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2978
do_concat_2977:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2978:
    str x0, [sp, #-16]!
    adr x0, concat
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2980
    tst x1, #1
    b.eq do_concat_2980
do_apply_2979:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2981
do_concat_2980:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2981:
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2983
    tst x1, #1
    b.eq do_concat_2983
do_apply_2982:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2984
do_concat_2983:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2984:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2986
    tst x1, #1
    b.eq do_concat_2986
do_apply_2985:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2987
do_concat_2986:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2987:
    str x0, [sp, #-16]!
    adr x0, asm_tail
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2989
    tst x1, #1
    b.eq do_concat_2989
do_apply_2988:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2990
do_concat_2989:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2990:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2992
    tst x1, #1
    b.eq do_concat_2992
do_apply_2991:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2993
do_concat_2992:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2993:
    str x0, [sp, #-16]!
    adr x0, ctx_tail
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2995
    tst x1, #1
    b.eq do_concat_2995
do_apply_2994:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2996
do_concat_2995:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2996:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2971
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_tail
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_2998
    tst x1, #1
    b.eq do_concat_2998
do_apply_2997:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_2999
do_concat_2998:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_2999:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_tail
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3001
    tst x1, #1
    b.eq do_concat_3001
do_apply_3000:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3002
do_concat_3001:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3002:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3004
    tst x1, #1
    b.eq do_concat_3004
do_apply_3003:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3005
do_concat_3004:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3005:
blk_end_2971:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3007
    tst x1, #1
    b.eq do_concat_3007
do_apply_3006:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3008
do_concat_3007:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3008:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2968
    adr x0, compile_stmts
    str x0, [sp, #-16]!
    adr x0, tail_stmts
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3010
    tst x1, #1
    b.eq do_concat_3010
do_apply_3009:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3011
do_concat_3010:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3011:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-48]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3013
    tst x1, #1
    b.eq do_concat_3013
do_apply_3012:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3014
do_concat_3013:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3014:
    str x0, [sp, #-16]!
    adr x0, ctx_head
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3016
    tst x1, #1
    b.eq do_concat_3016
do_apply_3015:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3017
do_concat_3016:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3017:
blk_end_2968:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3019
    tst x1, #1
    b.eq do_concat_3019
do_apply_3018:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3020
do_concat_3019:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3020:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2963
    adr x0, ctx_from_res
    str x0, [sp, #-16]!
    adr x0, res_head
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3022
    tst x1, #1
    b.eq do_concat_3022
do_apply_3021:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3023
do_concat_3022:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3023:
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    str x0, [sp, #-16]!
    adr x0, res_head
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3025
    tst x1, #1
    b.eq do_concat_3025
do_apply_3024:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3026
do_concat_3025:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3026:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3028
    tst x1, #1
    b.eq do_concat_3028
do_apply_3027:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3029
do_concat_3028:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3029:
blk_end_2963:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3031
    tst x1, #1
    b.eq do_concat_3031
do_apply_3030:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3032
do_concat_3031:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3032:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2946
    adr x0, compile_node
    str x0, [sp, #-16]!
    adr x0, head_stmt
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3034
    tst x1, #1
    b.eq do_concat_3034
do_apply_3033:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3035
do_concat_3034:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3035:
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3037
    tst x1, #1
    b.eq do_concat_3037
do_apply_3036:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3038
do_concat_3037:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3038:
blk_end_2946:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3040
    tst x1, #1
    b.eq do_concat_3040
do_apply_3039:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3041
do_concat_3040:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3041:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2943
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3043
    tst x1, #1
    b.eq do_concat_3043
do_apply_3042:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3044
do_concat_3043:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3044:
blk_end_2943:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3046
    tst x1, #1
    b.eq do_concat_3046
do_apply_3045:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3047
do_concat_3046:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3047:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_2940
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-64]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3049
    tst x1, #1
    b.eq do_concat_3049
do_apply_3048:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3050
do_concat_3049:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3050:
blk_end_2940:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2938_2939:
    // Closure for func_2938
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
    adr x1, func_2938
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2936_2937:
    // Closure for func_2936
    adr x0, sign_id
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _cons
    str x0, [sp, #-16]!
    adr x1, func_2936
    ldr x0, [sp], #16
    bl _cons
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_2934_2935:
    // Closure for func_2934
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_2934
    ldr x0, [sp], #16
    bl _cons
    b cond_end_2930
cond_false_2929:
    adr x0, sign_id
cond_end_2930:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, asm_from_res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3054
    tst x1, #1
    b.eq do_concat_3054
do_apply_3053:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3055
do_concat_3054:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3055:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3051
    b after_func_3056_3057
func_3056:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3059
    tst x1, #1
    b.eq do_concat_3059
do_apply_3058:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3060
do_concat_3059:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3060:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3056_3057:
    // Closure for func_3056
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3056
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3052
cond_false_3051:
    adr x0, sign_id
cond_end_3052:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_from_res
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3064
    tst x1, #1
    b.eq do_concat_3064
do_apply_3063:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3065
do_concat_3064:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3065:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3061
    b after_func_3066_3067
func_3066:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3069
    tst x1, #1
    b.eq do_concat_3069
do_apply_3068:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3070
do_concat_3069:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3070:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3072
    tst x1, #1
    b.eq do_concat_3072
do_apply_3071:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3073
do_concat_3072:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3073:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3066_3067:
    // Closure for func_3066
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3066
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3062
cond_false_3061:
    adr x0, sign_id
cond_end_3062:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, res_lbl_end
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3077
    tst x1, #1
    b.eq do_concat_3077
do_apply_3076:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3078
do_concat_3077:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3078:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3074
    b after_func_3079_3080
func_3079:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str_89
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3082
    tst x1, #1
    b.eq do_concat_3082
do_apply_3081:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3083
do_concat_3082:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3083:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3079_3080:
    // Closure for func_3079
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3079
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3075
cond_false_3074:
    adr x0, sign_id
cond_end_3075:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, ctx_from_lbl
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3087
    tst x1, #1
    b.eq do_concat_3087
do_apply_3086:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3088
do_concat_3087:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3088:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3084
    b after_func_3089_3090
func_3089:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    adr x0, tail
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3092
    tst x1, #1
    b.eq do_concat_3092
do_apply_3091:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3093
do_concat_3092:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3093:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3095
    tst x1, #1
    b.eq do_concat_3095
do_apply_3094:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3096
do_concat_3095:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3096:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3089_3090:
    // Closure for func_3089
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3089
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3085
cond_false_3084:
    adr x0, sign_id
cond_end_3085:
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, #
    str x0, [sp, #-16]!
    adr x0, is_literal_expr
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3100
    tst x1, #1
    b.eq do_concat_3100
do_apply_3099:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3101
do_concat_3100:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3101:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_3097
    b after_func_3102_3103
func_3102:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    b after_func_3104_3105
func_3104:
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
    b.eq cmp_true_3110
    adr x0, sign_id
    b cmp_end_3111
cmp_true_3110:
cmp_end_3111:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_3108
    b or_end_3109
or_right_3108:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ast_str
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3112
    adr x0, sign_id
    b cmp_end_3113
cmp_true_3112:
cmp_end_3113:
or_end_3109:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_3106
    b or_end_3107
or_right_3106:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, ast_char
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_3114
    adr x0, sign_id
    b cmp_end_3115
cmp_true_3114:
cmp_end_3115:
or_end_3107:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3104_3105:
    // Closure for func_3104
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3104
    ldr x0, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, head
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3117
    tst x1, #1
    b.eq do_concat_3117
do_apply_3116:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3118
do_concat_3117:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3118:
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_3120
    tst x1, #1
    b.eq do_concat_3120
do_apply_3119:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_3121
do_concat_3120:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_3121:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_3102_3103:
    // Closure for func_3102
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_3102
    ldr x0, [sp], #16
    bl _cons
    b cond_end_3098
cond_false_3097:
    adr x0, sign_id
cond_end_3098:
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
.balign 8
.global _str_start
_str_start:
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
    .asciz "    adr x9, heap_buffer\n"
str_12:
    .asciz "    cmp x1, x9\n"
str_13:
    .asciz "    b.lo "
str_14:
    .asciz "    tst x1, #1\n"
str_15:
    .asciz "    b.eq "
str_16:
    .asciz "    bic x1, x1, #1\n"
str_17:
    .asciz "    ldr x2, [x1]\n"
str_18:
    .asciz "    ldr x9, [x1, #8]\n"
str_19:
    .asciz "    blr x2\n"
str_20:
    .asciz "    b "
str_21:
    .asciz ":\n"
str_22:
    .asciz "    mov x2, x0\n"
str_23:
    .asciz "    mov x0, x1\n"
str_24:
    .asciz "    mov x1, x2\n"
str_25:
    .asciz "TODO: Check existence, return label. For now just add."
str_26:
    .asciz "str_"
str_27:
    .asciz ""
str_28:
    .asciz ".global _str_end\n_str_end:\n"
str_29:
    .asciz ":\n    .asciz \""
str_30:
    .asciz "\"\n"
str_31:
    .asciz "\n.data\n.balign 8\n.global _str_start\n_str_start:\n"
str_32:
    .asciz "Default"
str_33:
    .asciz "    // Unknown Node Type\n"
str_34:
    .asciz "    mov x0, #"
str_35:
    .asciz "    adr x0, sign_id\n"
str_36:
    .asciz "!!"
str_37:
    .asciz "Fallback"
str_38:
    .asciz "    bl _read_char\n"
str_39:
    .asciz "    ldr x0, [x0] // @ load\n"
str_40:
    .asciz "not_true"
str_41:
    .asciz "not_end"
str_42:
    .asciz "    adr x9, sign_id\n"
str_43:
    .asciz "    cmp x0, x9\n"
str_44:
    .asciz "    mov x0, #0\n"
str_45:
    .asciz "    mvn x0, x0\n"
str_46:
    .asciz "    bl _factorial\n"
str_47:
    .asciz "    add x0, x0, x1\n"
str_48:
    .asciz "    sub x0, x0, x1\n"
str_49:
    .asciz "    mul x0, x0, x1\n"
str_50:
    .asciz "    sdiv x0, x0, x1\n"
str_51:
    .asciz "eq"
str_52:
    .asciz "!="
str_53:
    .asciz "ne"
str_54:
    .asciz "lt"
str_55:
    .asciz "gt"
str_56:
    .asciz "<="
str_57:
    .asciz "le"
str_58:
    .asciz ">="
str_59:
    .asciz "ge"
str_60:
    .asciz "||"
str_61:
    .asciz "    orr x0, x1, x0\n"
str_62:
    .asciz "    bl _cons\n"
str_63:
    .asciz "~+"
str_64:
    .asciz "    bl _range\n"
str_65:
    .asciz "    bl _dict_get\n"
str_66:
    .asciz "    // Unknown Infix: "
str_67:
    .asciz "func"
str_68:
    .asciz "after_func"
str_69:
    .asciz "    stp x29, x30, [sp, #-16]!\n"
str_70:
    .asciz "    mov x29, sp\n"
str_71:
    .asciz "    str x0, [sp, #-16]!\n\ Push Arg"
str_72:
    .asciz "    mov sp, x29\n"
str_73:
    .asciz "    ldp x29, x30, [sp], #16\n"
str_74:
    .asciz "    ret\n"
str_75:
    .asciz "    adr x1, "
str_76:
    .asciz "    orr x0, x0, #1 // Tag closure\n"
str_77:
    .asciz "cmp_true"
str_78:
    .asciz "cmp_end"
str_79:
    .asciz "    cmp x0, x1\n"
str_80:
    .asciz "    b."
str_81:
    .asciz "or_right"
str_82:
    .asciz "or_end"
str_83:
    .asciz "and_fail"
str_84:
    .asciz "and_end"
str_85:
    .asciz "blk_end"
str_86:
    .asciz "Last Statement"
str_87:
    .asciz "Not Last Statement"
str_88:
    .asciz "    b.ne "
str_89:
    .asciz "Typo fix context usage above"

.global _str_end
_str_end:
