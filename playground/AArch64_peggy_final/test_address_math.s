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

    MOV x1, #0
    MOV x2, #0x0000
    MOVK x2, #0x4020, LSL #48
    FMOV d1, x2
    FCVTZS x2, d1 // Cast Double to Int
    ADD x3, x1, x2
    STR x3, [fp, #-8] // Bind 'a'
    MOV x2, x3
    MOV x2, #0x0000
    MOVK x2, #0x4020, LSL #48
    MOV x3, #0
    SCVTF d1, x3 // Cast Int to Double
    FMOV d0, x2
    FADD d2, d0, d1
    FMOV x1, d2
    STR x1, [fp, #-16] // Bind 'b'
    MOV x3, x1
    MOV x0, x3      // 最終結果を x0 にセット

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
