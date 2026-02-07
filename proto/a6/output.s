.global _start
.text
_start:
    adr x0, heap_buffer
    adr x1, heap_ptr
    str x0, [x1]
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    lsl x0, x1, x0
    adr x1, test_bit_lsl
    str x0, [x1]
    mov x0, #-8
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    asr x0, x1, x0
    adr x1, test_bit_asr
    str x0, [x1]
    ; Global Define test_bit_or = 1
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    eor x0, x1, x0
    adr x1, test_bit_xor
    str x0, [x1]
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    and x0, x1, x0
    adr x1, test_bit_and
    str x0, [x1]
    mov x0, #0
    mvn x0, x0
    adr x1, test_bit_not
    str x0, [x1]
    mov x0, #1
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_check_0
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_2
xor_true_check_0:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_check_1
    adr x0, sign_id
    b xor_end_2
xor_false_check_1:
    mov x0, x1
xor_end_2:
    adr x1, test_choice_1
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_check_3
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_5
xor_true_check_3:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_check_4
    adr x0, sign_id
    b xor_end_5
xor_false_check_4:
    mov x0, x1
xor_end_5:
    adr x1, test_choice_2
    str x0, [x1]
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_check_6
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_8
xor_true_check_6:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_check_7
    adr x0, sign_id
    b xor_end_8
xor_false_check_7:
    mov x0, x1
xor_end_8:
    adr x1, test_no_choice
    str x0, [x1]
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    adr x9, sign_id
    cmp x1, x9
    b.ne xor_true_check_9
    ldr x0, [sp], #16
    ldr x0, [sp], #16
    b xor_end_11
xor_true_check_9:
    ldr x1, [sp], #16
    ldr x0, [sp], #16
    adr x9, sign_id
    cmp x0, x9
    b.eq xor_false_check_10
    adr x0, sign_id
    b xor_end_11
xor_false_check_10:
    mov x0, x1
xor_end_11:
    adr x1, test_falsy
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.eq not_true_14
    adr x0, sign_id
    b not_end_15
not_true_14:
    mov x0, #0
not_end_15:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_12
    mov x0, #4
    b and_end_13
and_fail_12:
    adr x0, sign_id
and_end_13:
    adr x1, test_logic_not
    str x0, [x1]
    mov x0, #2
    str x0, [sp, #-16]!
    mov x0, #3
    ldr x1, [sp], #16
    bl _pow
    adr x1, test_pow
    str x0, [x1]
    mov x0, #5
    bl _factorial
    adr x1, test_fact
    str x0, [x1]
    mov x0, #-5
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    mov x0, #4
    ldr x1, [sp], #16
    mul x0, x1, x0
    cmp x0, #0
    cneg x0, x0, mi
    adr x1, test_abs
    str x0, [x1]
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _cons
    adr x1, test_cons
    str x0, [x1]
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #5
    ldr x1, [sp], #16
    bl _range
    adr x1, test_range
    str x0, [x1]
    adr x0, test_range
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #2
    ldr x1, [sp], #16
    bl _nth
    adr x1, test_get
    str x0, [x1]
    mov x0, #2
    str x0, [sp, #-16]!
    adr x0, test_range
    ldr x0, [x0]
    ldr x1, [sp], #16
    mov x9, x0
    mov x0, x1
    mov x1, x9
    bl _nth
    adr x1, test_get_at
    str x0, [x1]
    mov x8, #93       ; svc exit
    svc #0

sign_id:
    ret

.data

_pow:
    ; Simple loop implementation for integer pow
    ; x1 = base, x0 = exp
    ; Result in x0
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    cbz x0, .Lpow_one
    mov x2, x0 ; Counter
    mov x0, #1 ; Result
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
    ; x0 = n
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

_cons:
    ; x1 = head, x0 = tail
    ; Alloc 16 bytes: [head, tail]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    ; Load heap_ptr
    adr x9, heap_ptr
    ldr x2, [x9] ; x2 = current heap ptr
    
    str x1, [x2]      ; Store head
    str x0, [x2, #8]  ; Store tail
    
    mov x0, x2        ; Return ptr
    add x2, x2, #16   ; Bump ptr
    str x2, [x9]      ; Update heap_ptr
    
    ldp x29, x30, [sp], #16
    ret

_range:
    ; x1 = start, x0 = end
    ; Return list [start, start+1, ..., end]
    ; Recursive or Loop? Loop building from end?
    ; range(1, 3) -> [1, [2, [3, _]]]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    ; Save start(x1), end(x0)
    ; We build strictly from end down to start
    ; if start > end return Unit
    
    cmp x1, x0
    b.gt .Lrange_empty
    
    mov x9, x0 ; current = end
    adr x10, sign_id ; acc = Unit
    
.Lrange_loop:
    ; Cons(current, acc)
    ; Need to preserve regs? _cons uses x9, x2.
    ; Safe to use x19-x28 if saved.
    ; For prototype, just use stack.
    
    ; Optimized:
    ; cons(x9, x10) -> x10
    
    ; Call _cons? Inlines logic for speed/simplicity
    stp x9, x10, [sp, #-16]! ; PUSH current, acc
    
    ; Call cons(current, acc) -> result
    mov x1, x9
    mov x0, x10
    bl _cons
    mov x10, x0 ; acc = result
    
    ldp x9, x2, [sp], #16 ; POP current, old_acc (discard)
    
    sub x9, x9, #1
    cmp x9, x1 ; Compare current vs start
    b.ge .Lrange_loop ; if current >= start, continue
    
    mov x0, x10
    b .Lrange_end

.Lrange_empty:
    adr x0, sign_id
.Lrange_end:
    ldp x29, x30, [sp], #16
    ret

_nth:
    ; x1 = list, x0 = index
    ; Return list[index] or Unit
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    ; Check if list is unit
    adr x9, sign_id
    cmp x1, x9
    b.eq .Lnth_fail
    
.Lnth_loop:
    cbz x0, .Lnth_found
    
    ; List structure: [head, tail] at x1
    ; tail is at [x1, #8]
    ldr x1, [x1, #8]
    
    ; Check if tail is unit (end of list)
    cmp x1, x9
    b.eq .Lnth_fail
    
    sub x0, x0, #1
    b .Lnth_loop
    
.Lnth_found:
    ; Return head -> [x1]
    ldr x0, [x1]
    b .Lnth_end

.Lnth_fail:
    adr x0, sign_id

.Lnth_end:
    ldp x29, x30, [sp], #16
    ret
test_bit_lsl: .quad 0
test_bit_asr: .quad 0
test_bit_or: .quad 1
test_bit_xor: .quad 0
test_bit_and: .quad 0
test_bit_not: .quad 0
test_choice_1: .quad 0
test_choice_2: .quad 0
test_no_choice: .quad 0
test_falsy: .quad 0
test_logic_not: .quad 0
test_pow: .quad 0
test_fact: .quad 0
test_abs: .quad 0
test_cons: .quad 0
test_range: .quad 0
test_get: .quad 0
test_get_at: .quad 0

.bss
heap_buffer: .skip 65536
