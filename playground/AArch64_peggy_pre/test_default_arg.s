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
    MOV x4, x27 // Closure Ptr
    MOV x2, #0xFFFC
    MOVK x2, #0xFFFF, LSL #16
    MOVK x2, #0xFFFF, LSL #32
    MOVK x2, #0xFFFF, LSL #48
    STR x2, [x27, #0] // TypeTag_Closure
    ADRP x2, .L_func_f
    ADD  x2, x2, :lo12:.L_func_f
    STR x2, [x27, #8] // Func Ptr
    STR x1, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x4, [fp, #-8] // Bind function 'f'
    ADRP x4, Sign_Default_Trigger_Sentinel
    ADD  x4, x4, :lo12:Sign_Default_Trigger_Sentinel
    MOV x0, x4
    MOV x4, #0x0000
    MOVK x4, #0x4008, LSL #48
    MOV x0, x4
    LDR x4, [fp, #-8]
    LDR x8, [x4, #16] // Env Ptr
    LDR x4, [x4, #8] // Func Ptr
    BLR x4
    MOV x4, x0
    LDR x1, [x4, #0]
    MOV x2, #0xFFFC
    MOVK x2, #0xFFFF, LSL #16
    MOVK x2, #0xFFFF, LSL #32
    MOVK x2, #0xFFFF, LSL #48
    CMP x1, x2
    B.EQ .L_is_closure_dpzu3
    BLR x4
    B .L_call_8wj34
.L_is_closure_dpzu3:
    LDR x8, [x4, #16] // Env Ptr
    LDR x4, [x4, #8] // Func Ptr
    BLR x4
.L_call_8wj34:
    MOV x4, x0
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
.L_func_f:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg 'x'
    STR x1, [fp, #-16] // Save arg 'y'
    // Check default for 'y'
    LDR x2, [fp, #-16]
    ADRP x3, Sign_Default_Trigger_Sentinel
    ADD  x3, x3, :lo12:Sign_Default_Trigger_Sentinel
    CMP x2, x3
    B.NE .L_skip_def_p9ht3
    LDR x3, [fp, #-8] // Load 'x'
    MOV x2, #0x0000
    MOVK x2, #0x4000, LSL #48
    FMOV d0, x3
    FMOV d1, x2
    FADD d2, d0, d1
    FMOV x4, d2
    STR x4, [fp, #-16] // Update 'y' with default
.L_skip_def_p9ht3:
    LDR x4, [fp, #-16] // Load 'y'
    MOV x0, x4
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

