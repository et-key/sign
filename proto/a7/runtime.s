
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
heap_ptr: .quad 0

// Static Closures for Runtime Functions
// Closure = [CodePtr, EnvPtr]
.align 4
closure_print_str:
    .quad _print_str
    .quad sign_id

closure_print_char:
    .quad _print_char
    .quad sign_id

.bss
heap_buffer: .skip 65536
