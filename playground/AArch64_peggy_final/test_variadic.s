.section .rodata
.align 3
Sign_Unit_Sentinel:
    .quad 0x0000000000000000   // Unit (空リスト) の実体
Sign_Default_Trigger_Sentinel:
    .quad 0xFFFFFFFFFFFFFFFF   // Default Trigger (!_) の実体
.section .bss
.align 4
Sign_Project_Arena:
    .skip 1048576      // 1MB Arena
.section .rodata
.align 3
Sign_ListStatic_w7n3y:
    .quad 4 // Static List Length
    .quad 2 // Element 2
    .quad 3 // Element 3
    .quad 4 // Element 4
    .quad 5 // Element 5
.section .rodata
.align 3
Sign_ListStatic_92zdw:
    .quad 4 // Static List Length
    .quad 2 // Element 2
    .quad 3 // Element 3
    .quad 4 // Element 4
    .quad 5 // Element 5
.section .rodata
.align 3
Sign_ListStatic_67ve1:
    .quad 4 // Static List Length
    .quad 2 // Element 2
    .quad 3 // Element 3
    .quad 4 // Element 4
    .quad 5 // Element 5
.section .rodata
.align 3
Sign_ListStatic_775kq:
    .quad 4 // Static List Length
    .quad 2 // Element 2
    .quad 3 // Element 3
    .quad 4 // Element 4
    .quad 5 // Element 5

.text
.global _start
.align 2
_start:
    // --- Init Unit Sentinel (x28) ---
    ADRP x28, Sign_Unit_Sentinel
    ADD  x28, x28, :lo12:Sign_Unit_Sentinel

    // --- Init Project Arena (x27) ---
    ADRP x27, Sign_Project_Arena
    ADD  x27, x27, :lo12:Sign_Project_Arena

    // --- Setup Place Space (Stack Memory) ---
    MOV fp, sp
    SUB sp, sp, #256           // 変数領域を確保

    MOV x1, x27 // Env Ptr
    MOV x2, x27 // Closure Ptr
    MOV x3, #0xFFFC
    MOVK x3, #0xFFFF, LSL #16
    MOVK x3, #0xFFFF, LSL #32
    MOVK x3, #0xFFFF, LSL #48
    STR x3, [x27, #0] // TypeTag_Closure
    ADRP x3, .L_func_f
    ADD  x3, x3, :lo12:.L_func_f
    STR x3, [x27, #8] // Func Ptr
    STR x1, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x2, [fp, #-8] // Bind function 'f'
    MOV x2, x27 // Env Ptr
    MOV x1, x27 // Closure Ptr
    MOV x3, #0xFFFC
    MOVK x3, #0xFFFF, LSL #16
    MOVK x3, #0xFFFF, LSL #32
    MOVK x3, #0xFFFF, LSL #48
    STR x3, [x27, #0] // TypeTag_Closure
    ADRP x3, .L_func_g
    ADD  x3, x3, :lo12:.L_func_g
    STR x3, [x27, #8] // Func Ptr
    STR x2, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x1, [fp, #-16] // Bind function 'g'
    MOV x1, x27 // Env Ptr
    MOV x2, x27 // Closure Ptr
    MOV x3, #0xFFFC
    MOVK x3, #0xFFFF, LSL #16
    MOVK x3, #0xFFFF, LSL #32
    MOVK x3, #0xFFFF, LSL #48
    STR x3, [x27, #0] // TypeTag_Closure
    ADRP x3, .L_func_h
    ADD  x3, x3, :lo12:.L_func_h
    STR x3, [x27, #8] // Func Ptr
    STR x1, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x2, [fp, #-24] // Bind function 'h'
    ADRP x2, Sign_ListStatic_w7n3y
    ADD  x2, x2, :lo12:Sign_ListStatic_w7n3y
    MOV x0, x2
    MOV x2, #0x0000
    MOVK x2, #0x3ff0, LSL #48
    MOV x0, x2
    LDR x2, [fp, #-8]
    LDR x8, [x2, #16] // Env Ptr
    LDR x2, [x2, #8] // Func Ptr
    BLR x2
    MOV x2, x0
    LDR x1, [x2, #0]
    MOV x3, #0xFFFC
    MOVK x3, #0xFFFF, LSL #16
    MOVK x3, #0xFFFF, LSL #32
    MOVK x3, #0xFFFF, LSL #48
    CMP x1, x3
    B.EQ .L_is_closure_o4ezy
    BLR x2
    B .L_call_5q40c
.L_is_closure_o4ezy:
    LDR x8, [x2, #16] // Env Ptr
    LDR x2, [x2, #8] // Func Ptr
    BLR x2
.L_call_5q40c:
    MOV x2, x0
    STR x2, [fp, #-32] // Bind 'a'
    MOV x3, x2
    ADRP x3, Sign_ListStatic_92zdw
    ADD  x3, x3, :lo12:Sign_ListStatic_92zdw
    MOV x0, x3
    MOV x3, #0x0000
    MOVK x3, #0x3ff0, LSL #48
    MOV x0, x3
    LDR x3, [fp, #-16]
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
    MOV x3, x0
    LDR x2, [x3, #0]
    MOV x1, #0xFFFC
    MOVK x1, #0xFFFF, LSL #16
    MOVK x1, #0xFFFF, LSL #32
    MOVK x1, #0xFFFF, LSL #48
    CMP x2, x1
    B.EQ .L_is_closure_0bz6s
    BLR x3
    B .L_call_5wo35
.L_is_closure_0bz6s:
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
.L_call_5wo35:
    MOV x3, x0
    STR x3, [fp, #-40] // Bind 'b'
    MOV x1, x3
    ADRP x1, Sign_ListStatic_67ve1
    ADD  x1, x1, :lo12:Sign_ListStatic_67ve1
    MOV x0, x1
    MOV x1, #0x0000
    MOVK x1, #0x3ff0, LSL #48
    MOV x0, x1
    LDR x1, [fp, #-24]
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
    MOV x1, x0
    LDR x3, [x1, #0]
    MOV x2, #0xFFFC
    MOVK x2, #0xFFFF, LSL #16
    MOVK x2, #0xFFFF, LSL #32
    MOVK x2, #0xFFFF, LSL #48
    CMP x3, x2
    B.EQ .L_is_closure_n61v3
    BLR x1
    B .L_call_o9cg0
.L_is_closure_n61v3:
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
.L_call_o9cg0:
    MOV x1, x0
    STR x1, [fp, #-48] // Bind 'c'
    MOV x2, x1
    MOV x2, x27 // Env Ptr
    MOV x5, x27 // Closure Ptr
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    STR x4, [x27, #0] // TypeTag_Closure
    ADRP x4, .L_func_map
    ADD  x4, x4, :lo12:.L_func_map
    STR x4, [x27, #8] // Func Ptr
    STR x2, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x5, [fp, #-56] // Bind function 'map'
    ADRP x5, Sign_ListStatic_775kq
    ADD  x5, x5, :lo12:Sign_ListStatic_775kq
    MOV x0, x5
    MOV x5, #0x0000
    MOVK x5, #0x3ff0, LSL #48
    MOV x0, x5
    MOV x5, x27 // Env Ptr
    MOV x3, x27 // Closure Ptr
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    STR x4, [x27, #0] // TypeTag_Closure
    ADRP x4, .L_func_anon_5
    ADD  x4, x4, :lo12:.L_func_anon_5
    STR x4, [x27, #8] // Func Ptr
    STR x5, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    MOV x0, x3
    LDR x3, [fp, #-56]
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
    MOV x3, x0
    LDR x5, [x3, #0]
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    CMP x5, x4
    B.EQ .L_is_closure_ctgln
    BLR x3
    B .L_call_isyqi
.L_is_closure_ctgln:
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
.L_call_isyqi:
    MOV x3, x0
    LDR x4, [x3, #0]
    MOV x5, #0xFFFC
    MOVK x5, #0xFFFF, LSL #16
    MOVK x5, #0xFFFF, LSL #32
    MOVK x5, #0xFFFF, LSL #48
    CMP x4, x5
    B.EQ .L_is_closure_y21mk
    BLR x3
    B .L_call_ejgik
.L_is_closure_y21mk:
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
.L_call_ejgik:
    MOV x3, x0
    STR x3, [fp, #-64] // Bind 'mapped'
    MOV x5, x3
    MOV x0, x5      // 最終結果を x0 にセット

    // --- Check if Result is Unit ---
    CMP x0, x28
    B.EQ .L_exit_unit
    // Convert double to int for OS exit code (0-255)
    FMOV d0, x0
    FCVTZS x0, d0
    B .L_exit_normal
.L_exit_unit:
    MOV x0, #255               // Unitの場合は終了コード 255 (Debug)
.L_exit_normal:

    // --- Exit Syscall ---
    MOV x8, #93
    SVC #0

    // --- Functions ---
.L_func_f:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg 'x'
    STR x1, [fp, #-16] // Save arg 'y'
    LDR x2, [fp, #-8] // Load 'x'
    MOV x0, x2
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

.L_func_g:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg 'x'
    STR x1, [fp, #-16] // Save arg 'y'
    LDR x1, [fp, #-16] // Load 'y'
    MOV x0, x1
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

.L_func_h:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg 'x'
    STR x1, [fp, #-16] // Save arg 'y'
    LDR x2, [fp, #-16] // Load 'y'
    // Postfix ~
    MOV x0, x2
    BL .L_func_h
    MOV x2, x0
    MOV x0, x2
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

.L_func_map:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #32
    STR x0, [fp, #-8] // Save arg 'f'
    STR x1, [fp, #-16] // Save arg 'x'
    STR x2, [fp, #-24] // Save arg 'y'
    LDR x1, [fp, #-16] // Load 'x'
    MOV x0, x1
    LDR x1, [fp, #-8] // Load 'f'
    LDR x3, [x1] // Dereference @
    LDR x1, [x3, #0]
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    CMP x1, x4
    B.EQ .L_is_closure_p11lt
    BLR x3
    B .L_call_ug2u4
.L_is_closure_p11lt:
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
.L_call_ug2u4:
    MOV x3, x0
    LDR x4, [fp, #-24] // Load 'y'
    // Postfix ~
    MOV x0, x4
    LDR x4, [fp, #-8] // Load 'f'
    MOV x0, x4
    BL .L_func_map
    MOV x4, x0
    LDR x1, [x4, #0]
    MOV x5, #0xFFFC
    MOVK x5, #0xFFFF, LSL #16
    MOVK x5, #0xFFFF, LSL #32
    MOVK x5, #0xFFFF, LSL #48
    CMP x1, x5
    B.EQ .L_is_closure_ayao6
    BLR x4
    B .L_call_y590b
.L_is_closure_ayao6:
    LDR x8, [x4, #16] // Env Ptr
    LDR x4, [x4, #8] // Func Ptr
    BLR x4
.L_call_y590b:
    MOV x4, x0
    MOV x5, x27 // List pointer
    MOV x1, #2
    STR x1, [x27] // Store length
    STR x3, [x27, #8] // Store element 0
    STR x4, [x27, #16] // Store element 1
    ADD x27, x27, #32 // Advance Arena
    MOV x0, x5
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

.L_func_anon_5:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg '__pf_arg_idwx7'
    LDR x2, [fp, #-8] // Load '__pf_arg_idwx7'
    MOV x4, #0x0000
    MOVK x4, #0x4000, LSL #48
    FMOV d1, x4
    FMOV d0, x2
    FMUL d2, d0, d1
    FMOV x3, d2
    MOV x0, x3
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

