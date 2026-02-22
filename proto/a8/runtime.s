
.global _start
.global _print_char
.global _print_str
.global _read_char
.global _cons
.global _car
.global _cdr
.global _nth
.global _add
.global _sub
.global _mul
.global _div
.global _div
.global _eq
.global _ne
.global _lt
.global _gt
.global _le
.global _ge
.global _ge
.global _mod
.global _not
.global _abs
.global _bitnot
.global _heap_init
.global closure_print_str
.global closure_print_char
.global _pow
.global _factorial
.global _range
.global _str_at
.global heap_ptr
.global heap_buffer
.global sign_id

.text

.text


// --- Entry Point (Called by Kernel) ---
_start:
    bl _heap_init
    bl __sign_init
    // Result in x0
    mov x8, #93 // Given exit is 93 on Linux AArch64?
    // Wait, check syscall number.
    // Linux AArch64: exit = 93.
    svc #0

// --- Entry Point Helper (Called by linked compiler output) ---
_heap_init:
    adr x0, heap_buffer
    adr x1, heap_ptr
    str x0, [x1]
    
    adr x0, heap_string
    adr x1, heap_string_ptr
    str x0, [x1]
    ret


// --- IO ---

_print_char:
    // x0 = char code
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    mov x1, sp
    mov x0, #1 // stdout
    mov x2, #1 // len
    mov x8, #64 // write
    svc #0
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

_print_str:
    // x0 = ptr (asciz)
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x1, x0
    mov x2, #0
.Lstrlen:
    ldrb w3, [x1, x2]
    cbz w3, .Lstrlen_end
    add x2, x2, #1
    b .Lstrlen
.Lstrlen_end:
    mov x0, #1 // stdout
    mov x8, #64 // write
    svc #0
    ldp x29, x30, [sp], #16
    ret

_read_char:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #16
    mov x1, sp
    mov x0, #0 // stdin
    mov x2, #1
    mov x8, #63 // read
    svc #0
    cmp x0, #1
    b.ne .Lread_eof
    ldrb w0, [sp]
    b .Lread_done
.Lread_eof:
    mov x0, #-1
.Lread_done:
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

// --- String Heuristics ---
_is_string:
    // returns x0 = 1 if string pointer, 0 otherwise
    adr x9, _str_start
    adr x10, _str_end
    cmp x0, x9
    b.lo .L_is_str_dyn
    cmp x0, x10
    b.lo .L_is_str_true
.L_is_str_dyn:
    adr x9, heap_string
    adr x10, heap_string_ptr
    ldr x10, [x10]
    cmp x0, x9
    b.lo .L_is_str_false
    cmp x0, x10
    b.lo .L_is_str_true
.L_is_str_false:
    mov x0, #0
    ret
.L_is_str_true:
    mov x0, #1
    ret

// --- List / Memory ---

_cons:
    // x1 = head, x0 = tail
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x9, heap_ptr
    ldr x2, [x9]
    str x1, [x2]
    str x0, [x2, #8]
    mov x0, x2
    add x2, x2, #16
    str x2, [x9]
    ldp x29, x30, [sp], #16
    ret

    .global _concat
_concat:
    cbz x0, .Lconcat_empty

    stp x29, x30, [sp, #-32]!
    mov x29, sp

    str x0, [sp, #16] // Save A
    str x1, [sp, #24] // Save B

    bl _is_string
    mov x2, x0
    ldr x0, [sp, #24]
    str x2, [sp, #-16]!
    bl _is_string
    ldr x2, [sp], #16
    orr x2, x2, x0
    cbz x2, .Lconcat_is_list_or_scalar

    ldr x0, [sp, #16]
    bl _to_string
    str x0, [sp, #16]
    ldr x0, [sp, #24]
    bl _to_string
    mov x1, x0
    ldr x0, [sp, #16]
    bl _strcat
    ldp x29, x30, [sp], #32
    ret

.Lconcat_is_list_or_scalar:
    ldr x0, [sp, #16]
    ldr x1, [sp, #24]

    adr x9, heap_buffer
    adr x10, heap_ptr
    ldr x10, [x10]
    cmp x0, x9
    b.lo .Lconcat_scalar
    cmp x0, x10
    b.hs .Lconcat_scalar
    tst x0, #1
    b.ne .Lconcat_scalar

.Lconcat_list:
    ldr x0, [x0, #8]
    bl _concat
    ldr x2, [sp, #16]
    ldr x1, [x2]
    bl _cons
    ldp x29, x30, [sp], #32
    ret

.Lconcat_scalar:
    ldr x0, [sp, #24]
    ldr x1, [sp, #16]
    bl _cons
    ldp x29, x30, [sp], #32
    ret

.Lconcat_empty:
    mov x0, x1
    ret


_nth:
    // x1 = list, x0 = index
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x9, sign_id
    cmp x1, x9
    b.eq .Lnth_fail
.Lnth_loop:
    cbz x0, .Lnth_found
    ldr x1, [x1, #8] // tail
    cmp x1, x9
    b.eq .Lnth_fail
    sub x0, x0, #1
    b .Lnth_loop
.Lnth_found:
    ldr x0, [x1] // head
    b .Lnth_end
.Lnth_fail:
    adr x0, sign_id
.Lnth_end:
    ldp x29, x30, [sp], #16
    ret

    .global _dict_get
_dict_get:
    // x1 = Key Ptr, x0 = Dict List Ptr
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x9, sign_id
    cmp x0, x9
    b.eq .Ldict_fail
.Ldict_loop:
    // Extract Pair
    ldr x2, [x0]      // x2 = Pair [Key, Value]
    ldr x3, [x0, #8]  // x3 = Next Dict
    
    // Extract Key and Value
    ldr x4, [x2]      // x4 = Pair.Key Ptr
    ldr x5, [x2, #8]  // x5 = Pair.Value Ptr
    
    // Compare Keys (Pointer Comparison for literal string deduplication)
    cmp x1, x4
    b.eq .Ldict_found
    
    // Move to next
    mov x0, x3
    cmp x0, x9
    b.eq .Ldict_fail
    b .Ldict_loop
.Ldict_found:
    mov x0, x5
    b .Ldict_end
.Ldict_fail:
    adr x0, sign_id
.Ldict_end:
    ldp x29, x30, [sp], #16
    ret

sign_id:
    ret


// --- Comparisons ---
_eq:
    cmp x1, x0
    b.eq .Lcmp_true
    b .Lcmp_false

_ne:
    cmp x1, x0
    b.ne .Lcmp_true
    b .Lcmp_false

_lt:
    cmp x1, x0
    b.lt .Lcmp_true
    b .Lcmp_false

_gt:
    cmp x1, x0
    b.gt .Lcmp_true
    b .Lcmp_false

_le:
    cmp x1, x0
    b.le .Lcmp_true
    b .Lcmp_false

_ge:
    cmp x1, x0
    b.ge .Lcmp_true
    b .Lcmp_false

.Lcmp_true:
    ret // Return x0 (RHS)

.Lcmp_false:
    adr x0, sign_id
    ret

// --- Math Helpers ---
_pow:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    cbz x0, .Lpow_one
    mov x2, x0
    mov x0, #1
.Lpow_loop:
    cbz x2, .Lpow_end
    mul x0, x0, x1
    sub x2, x2, #1
    b .Lpow_loop
.Lpow_one:
    mov x0, #1
.Lpow_end:
    ldp x29, x30, [sp], #16
    ret

_factorial:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x1, x0
    mov x0, #1
    cmp x1, #1
    b.le .Lfact_end
.Lfact_loop:
    mul x0, x0, x1
    sub x1, x1, #1
    cmp x1, #1
    b.gt .Lfact_loop
.Lfact_end:
    ldp x29, x30, [sp], #16
    ret

_range:
    cmp x1, x0
    b.gt .Lrange_empty
    mov x9, x0
    adr x10, sign_id
.Lrange_loop:
    stp x9, x10, [sp, #-16]!
    mov x1, x9
    mov x0, x10
    bl _cons
    mov x10, x0
    ldp x9, x2, [sp], #16
    sub x9, x9, #1
    cmp x9, x1
    b.ge .Lrange_loop
    mov x0, x10
    b .Lrange_end
.Lrange_empty:
    adr x0, sign_id
.Lrange_end:
    ldp x29, x30, [sp], #16
    ret

_str_at:
    ldrb w0, [x1, x0]
    ret

.data
.align 8
heap_ptr: .quad 0
heap_string_ptr: .quad 0

// Static Closures for Runtime Functions
// Closure = [CodePtr, EnvPtr]
.align 8
closure_print_str:
    .quad _print_str
    .quad sign_id

closure_print_char:
    .quad _print_char
    .quad sign_id

.bss
.align 16
heap_buffer: .skip 16777216
heap_string: .skip 16777216

.text
// --- String Parsing Coercion ---
_to_int:
    stp x29, x30, [sp, #-16]!
    str x0, [sp, #-16]!
    bl _is_string
    cbz x0, .L_to_int_done
    ldr x1, [sp]
    mov x0, #0
    mov x2, #10
.L_to_int_loop:
    ldrb w3, [x1], #1
    cbz w3, .L_to_int_end
    sub w3, w3, #48
    cmp w3, #9
    b.hi .L_to_int_end
    mul x0, x0, x2
    add x0, x0, x3
    b .L_to_int_loop
.L_to_int_end:
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret
.L_to_int_done:
    ldr x0, [sp], #16
    ldp x29, x30, [sp], #16
    ret

_to_string:
    stp x29, x30, [sp, #-16]!
    str x0, [sp, #-16]!
    bl _is_string
    cbnz x0, .L_to_str_done
    ldr x0, [sp]
    
    adr x9, heap_string_ptr
    ldr x1, [x9]
    mov x12, x1
    add x2, x1, #24
    str x2, [x9]
    
    cbnz x0, .L_to_str_not_zero
    mov w3, #48
    strb w3, [x1], #1
    strb wzr, [x1]
    mov x0, x12
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

.L_to_str_not_zero:
    add x1, x12, #24
    strb wzr, [x1, #-1]!
    mov x2, #10
.L_to_str_loop:
    cbz x0, .L_to_str_copy
    udiv x3, x0, x2
    msub x4, x3, x2, x0
    add w4, w4, #48
    strb w4, [x1, #-1]!
    mov x0, x3
    b .L_to_str_loop
.L_to_str_copy:
    mov x0, x1
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

.L_to_str_done:
    ldr x0, [sp], #16
    ldp x29, x30, [sp], #16
    ret

_strcat:
    stp x29, x30, [sp, #-16]!
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    
    adr x9, heap_string_ptr
    ldr x2, [x9]
    str x2, [sp, #-16]!
    
.L_strcat_a:
    ldrb w3, [x0], #1
    cbz w3, .L_strcat_b
    strb w3, [x2], #1
    b .L_strcat_a
.L_strcat_b:
    ldr x1, [sp, #16]
.L_strcat_b_loop:
    ldrb w3, [x1], #1
    cbz w3, .L_strcat_end
    strb w3, [x2], #1
    b .L_strcat_b_loop
.L_strcat_end:
    strb wzr, [x2], #1
    add x2, x2, #7
    bic x2, x2, #7
    adr x9, heap_string_ptr
    str x2, [x9]
    
    ldr x0, [sp], #16
    add sp, sp, #32
    ldp x29, x30, [sp], #16
    ret
