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
Sign_Str_3gran:
    .quad 1 // Length
    .quad 120 // 'x'
.section .rodata
.align 3
Sign_Str_7st2e:
    .quad 1 // Length
    .quad 121 // 'y'

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

    ADRP x1, Sign_Str_3gran
    ADD  x1, x1, :lo12:Sign_Str_3gran
    MOV x2, #0x0000
    MOVK x2, #0x4024, LSL #48
    MOV x3, x27 // Dict pointer
    MOV x4, #0xFFFD
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    STR x4, [x27, #0] // TypeTag_Dict
    MOV x4, #1
    STR x4, [x27, #8] // Length
    STR x1, [x27, #16] // Store Key 0
    STR x2, [x27, #24] // Store Value 0
    ADD x27, x27, #32 // Advance Arena
    STR x3, [fp, #-8] // Bind 'width'
    MOV x2, x3
    ADRP x2, Sign_Str_7st2e
    ADD  x2, x2, :lo12:Sign_Str_7st2e
    MOV x3, #0x0000
    MOVK x3, #0x4034, LSL #48
    MOV x1, x27 // Dict pointer
    MOV x4, #0xFFFD
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    STR x4, [x27, #0] // TypeTag_Dict
    MOV x4, #1
    STR x4, [x27, #8] // Length
    STR x2, [x27, #16] // Store Key 0
    STR x3, [x27, #24] // Store Value 0
    ADD x27, x27, #32 // Advance Arena
    STR x1, [fp, #-16] // Bind 'weight'
    MOV x3, x1
    LDR x3, [fp, #-16] // Load 'weight'
    LDR x1, [fp, #-8] // Load 'width'
    MOV x2, x27 // List pointer
    MOV x4, #2
    STR x4, [x27] // Store length
    STR x3, [x27, #8] // Store element 0
    STR x1, [x27, #16] // Store element 1
    ADD x27, x27, #32 // Advance Arena
    STR x2, [fp, #-24] // Bind 'BMI'
    MOV x1, x2
    MOV x0, x1      // 最終結果を x0 にセット

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
