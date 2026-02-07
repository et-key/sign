
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
.global _heap_init

.text

; --- Entry Point Helper (Called by linked compiler output) ---
_heap_init:
    adr x0, heap_buffer
    adr x1, heap_ptr
    str x0, [x1]
    ret

; --- IO ---

_print_char:
    ; x0 = char code
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    mov x1, sp
    mov x0, #1 ; stdout
    mov x2, #1 ; len
    mov x8, #64 ; write
    svc #0
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

_print_str:
    ; x0 = ptr (asciz)
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
    mov x0, #1 ; stdout
    mov x8, #64 ; write
    svc #0
    ldp x29, x30, [sp], #16
    ret

_read_char:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #16
    mov x1, sp
    mov x0, #0 ; stdin
    mov x2, #1
    mov x8, #63 ; read
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

; --- List / Memory ---

_cons:
    ; x1 = head, x0 = tail
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
    ; x1 = list, x0 = index
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    adr x9, sign_id
    cmp x1, x9
    b.eq .Lnth_fail
.Lnth_loop:
    cbz x0, .Lnth_found
    ldr x1, [x1, #8] ; tail
    cmp x1, x9
    b.eq .Lnth_fail
    sub x0, x0, #1
    b .Lnth_loop
.Lnth_found:
    ldr x0, [x1] ; head
    b .Lnth_end
.Lnth_fail:
    adr x0, sign_id
.Lnth_end:
    ldp x29, x30, [sp], #16
    ret

sign_id:
    ret

.data
heap_ptr: .quad 0

.bss
heap_buffer: .skip 65536
