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
    MOV x3, x27 // Closure Ptr
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    STR x4, [x27, #0] // TypeTag_Closure
    ADRP x4, .L_func_F
    ADD  x4, x4, :lo12:.L_func_F
    STR x4, [x27, #8] // Func Ptr
    STR x1, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x3, [fp, #-8] // Bind function 'F'
    MOV x3, #0x0000
    MOVK x3, #0x4008, LSL #48
    MOV x0, x3
    MOV x3, x27 // Env Ptr
    MOV x2, x27 // Closure Ptr
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    STR x4, [x27, #0] // TypeTag_Closure
    ADRP x4, .L_func_anon_2
    ADD  x4, x4, :lo12:.L_func_anon_2
    STR x4, [x27, #8] // Func Ptr
    STR x3, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    MOV x0, x2
    LDR x2, [fp, #-8]
    LDR x8, [x2, #16] // Env Ptr
    LDR x2, [x2, #8] // Func Ptr
    BLR x2
    MOV x2, x0
    LDR x3, [x2, #0]
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    CMP x3, x4
    B.EQ .L_is_closure_4c3yp
    BLR x2
    B .L_call_4vabc
.L_is_closure_4c3yp:
    LDR x8, [x2, #16] // Env Ptr
    LDR x2, [x2, #8] // Func Ptr
    BLR x2
.L_call_4vabc:
    MOV x2, x0
    STR x2, [fp, #-16] // Bind 'b'
    MOV x4, x2
    MOV x0, x4      // 最終結果を x0 にセット

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
.L_func_F:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg 'f'
    STR x1, [fp, #-16] // Save arg 'x'
    LDR x2, [fp, #-16] // Load 'x'
    MOV x0, x2
    LDR x2, [fp, #-8] // Load 'f'
    LDR x3, [x2] // Dereference @
    LDR x2, [x3, #0]
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    CMP x2, x4
    B.EQ .L_is_closure_43z0c
    BLR x3
    B .L_call_moy1k
.L_is_closure_43z0c:
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
.L_call_moy1k:
    MOV x3, x0
    MOV x0, x3
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

.L_func_anon_2:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg '__pf_arg_nqr3w'
    LDR x1, [fp, #-8] // Load '__pf_arg_nqr3w'
    MOV x4, #0x0000
    MOVK x4, #0x4000, LSL #48
    FMOV d1, x4
    FMOV d0, x1
    FADD d2, d0, d1
    FMOV x2, d2
    MOV x0, x2
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

