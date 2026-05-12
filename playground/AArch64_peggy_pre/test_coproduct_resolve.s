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
    ADRP x3, .L_func_f
    ADD  x3, x3, :lo12:.L_func_f
    STR x3, [x27, #8] // Func Ptr
    STR x1, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x2, [fp, #-8] // Bind function 'f'
    MOV x2, x27 // Env Ptr
    MOV x4, x27 // Closure Ptr
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
    STR x4, [fp, #-16] // Bind function 'g'
    MOV x4, x27 // Env Ptr
    MOV x2, x27 // Closure Ptr
    MOV x3, #0xFFFC
    MOVK x3, #0xFFFF, LSL #16
    MOVK x3, #0xFFFF, LSL #32
    MOVK x3, #0xFFFF, LSL #48
    STR x3, [x27, #0] // TypeTag_Closure
    ADRP x3, .L_func_h
    ADD  x3, x3, :lo12:.L_func_h
    STR x3, [x27, #8] // Func Ptr
    STR x4, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    STR x2, [fp, #-24] // Bind function 'h'
    MOV x2, #0x0000
    MOVK x2, #0x3ff0, LSL #48
    MOV x0, x2
    LDR x2, [fp, #-8]
    LDR x8, [x2, #16] // Env Ptr
    LDR x2, [x2, #8] // Func Ptr
    BLR x2
    MOV x2, x0
    MOV x4, #0x0000
    MOVK x4, #0x4000, LSL #48
    MOV x3, #0x0000
    MOVK x3, #0x4008, LSL #48
    FMOV d0, x4
    FMOV d1, x3
    FADD d2, d0, d1
    FMOV x1, d2
    MOV x3, #0x0000
    MOVK x3, #0x4010, LSL #48
    FMOV d0, x1
    FMOV d1, x3
    FADD d2, d0, d1
    FMOV x4, d2
    MOV x3, #0x0000
    MOVK x3, #0x4018, LSL #48
    MOV x0, x3
    MOV x3, #0x0000
    MOVK x3, #0x4014, LSL #48
    MOV x0, x3
    LDR x3, [fp, #-16]
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
    MOV x3, x0
    LDR x1, [x3, #0]
    MOV x5, #0xFFFC
    MOVK x5, #0xFFFF, LSL #16
    MOVK x5, #0xFFFF, LSL #32
    MOVK x5, #0xFFFF, LSL #48
    CMP x1, x5
    B.EQ .L_is_closure_3v7f7
    BLR x3
    B .L_call_63xzb
.L_is_closure_3v7f7:
    LDR x8, [x3, #16] // Env Ptr
    LDR x3, [x3, #8] // Func Ptr
    BLR x3
.L_call_63xzb:
    MOV x3, x0
    MOV x5, #0x0000
    MOVK x5, #0x401c, LSL #48
    MOV x1, x27 // List pointer
    MOV x6, #4
    STR x6, [x27] // Store length
    STR x2, [x27, #8] // Store element 0
    STR x4, [x27, #16] // Store element 1
    STR x3, [x27, #24] // Store element 2
    STR x5, [x27, #32] // Store element 3
    ADD x27, x27, #48 // Advance Arena
    STR x1, [fp, #-32] // Bind 'a'
    MOV x5, x1
    MOV x5, #0x0000
    MOVK x5, #0x4018, LSL #48
    MOV x0, x5
    MOV x5, #0x0000
    MOVK x5, #0x4014, LSL #48
    MOV x0, x5
    MOV x5, x27 // Env Ptr
    LDR x1, [fp, #-16] // capture 'g'
    STR x1, [x5, #0]
    LDR x1, [fp, #-24] // capture 'h'
    STR x1, [x5, #8]
    ADD x27, x27, #16
    MOV x1, x27 // Closure Ptr
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    STR x4, [x27, #0] // TypeTag_Closure
    ADRP x4, .L_func_anon_4
    ADD  x4, x4, :lo12:.L_func_anon_4
    STR x4, [x27, #8] // Func Ptr
    STR x5, [x27, #16] // Env Ptr
    ADD x27, x27, #32 // Advance Arena
    LDR x5, [x1, #0]
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    CMP x5, x4
    B.EQ .L_is_closure_d3msd
    BLR x1
    B .L_call_bx5pq
.L_is_closure_d3msd:
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
.L_call_bx5pq:
    MOV x1, x0
    LDR x4, [x1, #0]
    MOV x5, #0xFFFC
    MOVK x5, #0xFFFF, LSL #16
    MOVK x5, #0xFFFF, LSL #32
    MOVK x5, #0xFFFF, LSL #48
    CMP x4, x5
    B.EQ .L_is_closure_hx9pp
    BLR x1
    B .L_call_fyjv3
.L_is_closure_hx9pp:
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
.L_call_fyjv3:
    MOV x1, x0
    MOV x5, #0x0000
    MOVK x5, #0x401c, LSL #48
    MOV x4, x27 // List pointer
    MOV x3, #2
    STR x3, [x27] // Store length
    STR x1, [x27, #8] // Store element 0
    STR x5, [x27, #16] // Store element 1
    ADD x27, x27, #32 // Advance Arena
    STR x4, [fp, #-40] // Bind 'b'
    MOV x5, x4
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

.L_func_h:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #32
    STR x0, [fp, #-8] // Save arg 'x'
    STR x1, [fp, #-16] // Save arg 'y'
    STR x2, [fp, #-24] // Save arg 'z'
    LDR x2, [fp, #-24] // Load 'z'
    LDR x3, [fp, #-16] // Load 'y'
    FMOV d0, x2
    FMOV d1, x3
    FDIV d2, d0, d1
    FMOV x1, d2
    LDR x3, [fp, #-8] // Load 'x'
    FMOV d0, x1
    FMOV d1, x3
    FDIV d2, d0, d1
    FMOV x2, d2
    MOV x0, x2
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

.L_func_anon_4:
    // Prologue
    STP fp, lr, [sp, #-16]!
    MOV fp, sp
    SUB sp, sp, #16
    STR x0, [fp, #-8] // Save arg '__cargA_kpzfe_0'
    STR x1, [fp, #-16] // Save arg '__cargB_3jcnv_1'
    LDR x1, [fp, #-16] // Load '__cargB_3jcnv_1'
    MOV x0, x1
    LDR x1, [fp, #-8] // Load '__cargA_kpzfe_0'
    MOV x0, x1
    MOV x1, #0x0000
    MOVK x1, #0x4000, LSL #48
    MOV x3, #0x0000
    MOVK x3, #0x4008, LSL #48
    FMOV d0, x1
    FMOV d1, x3
    FADD d2, d0, d1
    FMOV x4, d2
    MOV x3, #0x0000
    MOVK x3, #0x4010, LSL #48
    FMOV d0, x4
    FMOV d1, x3
    FADD d2, d0, d1
    FMOV x1, d2
    MOV x0, x1
    MOV x1, #0x0000
    MOVK x1, #0x3ff0, LSL #48
    MOV x0, x1
    LDR x1, [x8, #8]
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
    MOV x1, x0
    LDR x3, [x1, #0]
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    CMP x3, x4
    B.EQ .L_is_closure_f1had
    BLR x1
    B .L_call_k5exp
.L_is_closure_f1had:
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
.L_call_k5exp:
    MOV x1, x0
    LDR x4, [x1, #0]
    MOV x3, #0xFFFC
    MOVK x3, #0xFFFF, LSL #16
    MOVK x3, #0xFFFF, LSL #32
    MOVK x3, #0xFFFF, LSL #48
    CMP x4, x3
    B.EQ .L_is_closure_vizju
    BLR x1
    B .L_call_8r4ua
.L_is_closure_vizju:
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
.L_call_8r4ua:
    MOV x1, x0
    MOV x0, x1
    LDR x1, [x8, #0]
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
    MOV x1, x0
    LDR x3, [x1, #0]
    MOV x4, #0xFFFC
    MOVK x4, #0xFFFF, LSL #16
    MOVK x4, #0xFFFF, LSL #32
    MOVK x4, #0xFFFF, LSL #48
    CMP x3, x4
    B.EQ .L_is_closure_kl3oy
    BLR x1
    B .L_call_4ahuk
.L_is_closure_kl3oy:
    LDR x8, [x1, #16] // Env Ptr
    LDR x1, [x1, #8] // Func Ptr
    BLR x1
.L_call_4ahuk:
    MOV x1, x0
    MOV x0, x1
    // Epilogue
    MOV sp, fp
    LDP fp, lr, [sp], #16
    RET

