.section .rodata
.align 3
Sign_Unit_Sentinel:
    .quad 0x0000000000000000   // Unit (空リスト) の実体

.text
.global _start
.align 2
_start:
    // --- Init Unit Sentinel (x28) ---
    ADRP x28, Sign_Unit_Sentinel
    ADD  x28, x28, :lo12:Sign_Unit_Sentinel

    // --- Setup Place Space (Stack Memory) ---
    SUB sp, sp, #256           // 変数領域を確保

    MOV x2, #10
    MOV x0, x2
    BL .L_func_div2
    MOV x2, x0
    STR x2, [sp, #0] // Bind 'Result' to Memory
    MOV x3, x2
    MOV x0, x3      // 最終結果を x0 にセット

    // --- Check if Result is Unit ---
    CMP x0, x28
    B.NE .L_exit_normal
    MOV x0, #255               // Unitの場合は終了コード 255 (Debug)
.L_exit_normal:

    // --- Exit Syscall ---
    MOV x8, #93
    SVC #0

    // --- Functions ---
.L_func_div:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    STR x0, [sp, #-8]! // Save arg 'x'
    STR x1, [sp, #-8]! // Save arg 'y'
    LDR x1, [sp, #-8] // Load 'x'
    LDR x2, [sp, #-16] // Load 'y'
    SDIV x3, x1, x2
    MOV x0, x3
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

.L_func_div2:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    STR x0, [sp, #-8]! // Save arg '__p_arg_vtsst'
    LDR x3, [sp, #-8] // Load '__p_arg_vtsst'
    MOV x2, #2
    MOV x0, x3
    MOV x1, x2
    BL .L_func_div
    MOV x2, x0
    MOV x0, x2
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

