
.global _start
.align 2
_start:
    // Entry point
    mov x8, #214
    mov x0, #0
    svc #0
    adrp x1, heap_ptr
    add x1, x1, :lo12:heap_ptr
    str x0, [x1]
    mov x2, #67108864
    add x0, x0, x2
    mov x8, #214
    svc #0
    b skip_section_2
section_get_1:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    mov x0, #0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x1, #0
    b.ne not_head_3
    ldr x0, [x0]
    ret
not_head_3:
    ldr x0, [x0, #8]
    ldp x29, x30, [sp], #16
    ret
skip_section_2:
    adr x0, section_get_1
    adrp x1, head
    add x1, x1, :lo12:head
    str x0, [x1]
    str x0, [sp, #-16]!
    b skip_section_5
section_get_4:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    mov x0, #1
    neg x0, x0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x1, #0
    b.ne not_head_6
    ldr x0, [x0]
    ret
not_head_6:
    ldr x0, [x0, #8]
    ldp x29, x30, [sp], #16
    ret
skip_section_5:
    adr x0, section_get_4
    mov x9, x0
    ldr x0, [sp], #16
    blr x9
    adrp x1, tail
    add x1, x1, :lo12:tail
    str x0, [x1]
    mov x0, #10
    str x0, [sp, #-16]!
    mov x0, #20
    str x0, [sp, #-16]!
    mov x0, #30
    str x0, [sp, #-16]!
    adrp x1, heap_ptr
    add x1, x1, :lo12:heap_ptr
    ldr x0, [x1]
    add x2, x0, #16
    str x2, [x1]
    ldr x2, [sp], #16
    str x2, [x0, #8]
    ldr x2, [sp], #16
    str x2, [x0]
    str x0, [sp, #-16]!
    adrp x1, heap_ptr
    add x1, x1, :lo12:heap_ptr
    ldr x0, [x1]
    add x2, x0, #16
    str x2, [x1]
    ldr x2, [sp], #16
    str x2, [x0, #8]
    ldr x2, [sp], #16
    str x2, [x0]
    adrp x1, list
    add x1, x1, :lo12:list
    str x0, [x1]
    adrp x0, list
    add x0, x0, :lo12:list
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [sp], #16
    bl head
    adrp x1, h
    add x1, x1, :lo12:h
    str x0, [x1]
    adrp x0, list
    add x0, x0, :lo12:list
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [sp], #16
    bl tail
    adrp x1, t
    add x1, x1, :lo12:t
    str x0, [x1]
    mov x8, #93
    svc #0
.data
.align 3
heap_ptr: .quad 0
head: .quad 0
tail: .quad 0
list: .quad 0
h: .quad 0
t: .quad 0
