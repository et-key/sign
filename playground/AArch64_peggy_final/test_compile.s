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

    // TODO: ListConstruct
    STR x28, [sp, #0] // Bind 'list' to Memory
    MOV x1, x28
    MOV x0, x1      // 最終結果を x0 にセット

    // --- Check if Result is Unit ---
    CMP x0, x28
    B.NE .L_exit_normal
    MOV x0, #255               // Unitの場合は終了コード 255 (Debug)
.L_exit_normal:

    // --- Exit Syscall ---
    MOV x8, #93
    SVC #0
