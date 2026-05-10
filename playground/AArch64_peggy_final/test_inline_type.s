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
    MOV x2, x27 // Closure Ptr
    MOV x3, #0xFFFC
    MOVK x3, #0xFFFF, LSL #16
    MOVK x3, #0xFFFF, LSL #32
    MOVK x3, #0xFFFF, LSL #48
    STR x3, [x27, #0] // TypeTag_Closure
    ADRP x3, .L_func_identity
    ADD  x3, x3, :lo12:.L_func_identity
    STR x3, [x27, #8] // Func Ptr
    STR x1, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x2, [fp, #-8] // Bind function 'identity'
    MOV x2, x27 // Env Ptr
    MOV x4, x27 // Closure Ptr
    MOV x3, #0xFFFC
    MOVK x3, #0xFFFF, LSL #16
    MOVK x3, #0xFFFF, LSL #32
    MOVK x3, #0xFFFF, LSL #48
    STR x3, [x27, #0] // TypeTag_Closure
    ADRP x3, .L_func_add
    ADD  x3, x3, :lo12:.L_func_add
    STR x3, [x27, #8] // Func Ptr
    STR x2, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x4, [fp, #-16] // Bind function 'add'
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
.L_func_identity:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg 'x'
    LDR x2, [fp, #-8] // Load 'x'
    MOV x0, x2
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

.L_func_add:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg 'x'
    STR x1, [fp, #-16] // Save arg 'y'
    LDR x1, [fp, #-8] // Load 'x'
    LDR x3, [fp, #-16] // Load 'y'
    FMOV d0, x1
    FMOV d1, x3
    FADD d2, d0, d1
    FMOV x4, d2
    MOV x0, x4
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

