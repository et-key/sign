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
Sign_Str_voebp:
    .quad 4 // Length
    .quad 110 // 'n'
    .quad 97 // 'a'
    .quad 109 // 'm'
    .quad 101 // 'e'
.section .rodata
.align 3
Sign_Str_v5syf:
    .quad 3 // Length
    .quad 97 // 'a'
    .quad 103 // 'g'
    .quad 101 // 'e'
.section .rodata
.align 3
Sign_Str_gz2v3:
    .quad 3 // Length
    .quad 97 // 'a'
    .quad 103 // 'g'
    .quad 101 // 'e'

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

    ADRP x1, Sign_Str_voebp
    ADD  x1, x1, :lo12:Sign_Str_voebp
    MOV x2, #0x0000
    MOVK x2, #0x4024, LSL #48
    ADRP x3, Sign_Str_v5syf
    ADD  x3, x3, :lo12:Sign_Str_v5syf
    MOV x4, #0x0000
    MOVK x4, #0x4045, LSL #48
    MOV x5, x27 // Dict pointer
    MOV x6, #0xFFFD
    MOVK x6, #0xFFFF, LSL #16
    MOVK x6, #0xFFFF, LSL #32
    MOVK x6, #0xFFFF, LSL #48
    STR x6, [x27, #0] // TypeTag_Dict
    MOV x6, #2
    STR x6, [x27, #8] // Length
    STR x1, [x27, #16] // Store Key 0
    STR x2, [x27, #24] // Store Value 0
    STR x3, [x27, #32] // Store Key 1
    STR x4, [x27, #40] // Store Value 1
    ADD x27, x27, #48 // Advance Arena
    STR x5, [fp, #-8] // Bind 'd'
    MOV x4, x5
    LDR x4, [fp, #-8] // Load 'd'
    ADRP x5, Sign_Str_gz2v3
    ADD  x5, x5, :lo12:Sign_Str_gz2v3
    LDR x2, [x4, #0] // TypeTag
    MOV x1, #0xFFFD
    MOVK x1, #0xFFFF, LSL #16
    MOVK x1, #0xFFFF, LSL #32
    MOVK x1, #0xFFFF, LSL #48
    CMP x2, x1
    B.EQ .L_is_dict_tr6n2
    MOV x3, x28 // Not a dict -> Unit
    B .L_get_str_end_3em2b
.L_is_dict_tr6n2:
    LDR x1, [x4, #8]
    MOV x6, #0
    ADD x7, x4, #16
.L_dict_loop_ll8v2:
    CMP x6, x1
    B.GE .L_dict_not_found_aketf
    LDR x9, [x7] // dict key ptr
    LDR x10, [x9]
    LDR x11, [x5]
    MOV x13, #0
    CMP x10, x11
    B.NE .L_strcmp_end_aqz3f
    MOV x12, #0
.L_strcmp_loop_02qfh:
    CMP x12, x10
    B.GE 1f // match!
    ADD x2, x12, #1
    LSL x2, x2, #3
    LDR x11, [x9, x2]
    LDR x14, [x5, x2]
    CMP x11, x14
    B.NE .L_strcmp_end_aqz3f // char differs
    ADD x12, x12, #1
    B .L_strcmp_loop_02qfh
1:
    MOV x13, #1 // match = true
.L_strcmp_end_aqz3f:
    CMP x13, #1
    B.EQ 2f // matched!
    ADD x7, x7, #16
    ADD x6, x6, #1
    B .L_dict_loop_ll8v2
.L_dict_not_found_aketf:
    MOV x3, x28 // Unit
    B .L_get_str_end_3em2b
2: // Matched
    LDR x3, [x7, #8] // Value ptr
.L_get_str_end_3em2b:
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
