// Sign Compiler Output
// Target: aarch64
// Mode: compile
// Exception Level: 0
// Link: static
// Options: debug=true, optimize=false

.global __sign_init
.text
__sign_init:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    mov x0, #32
    adr x1, test
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_0
    str x0, [sp, #-16]!
    mov x0, #123
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_4
    tst x1, #1
    b.eq do_concat_4
do_apply_3:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_5
do_concat_4:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_5:
    str x0, [sp, #-16]!
    adr x0, str_1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_1
    adr x0, sign_id
    b cmp_end_2
cmp_true_1:
cmp_end_2:
    adr x1, t1
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #123
    str x0, [sp, #-16]!
    adr x0, str_0
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_9
    tst x1, #1
    b.eq do_concat_9
do_apply_8:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_10
do_concat_9:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_10:
    str x0, [sp, #-16]!
    adr x0, str_2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_6
    adr x0, sign_id
    b cmp_end_7
cmp_true_6:
cmp_end_7:
    adr x1, t2
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, test
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #12
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_14
    tst x1, #1
    b.eq do_concat_14
do_apply_13:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_15
do_concat_14:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_15:
    str x0, [sp, #-16]!
    mov x0, #32
    str x0, [sp, #-16]!
    mov x0, #12
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_17
    tst x1, #1
    b.eq do_concat_17
do_apply_16:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_18
do_concat_17:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_18:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_11
    adr x0, sign_id
    b cmp_end_12
cmp_true_11:
cmp_end_12:
    adr x1, t3
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #12
    str x0, [sp, #-16]!
    adr x0, test
    ldr x0, [x0]
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_22
    tst x1, #1
    b.eq do_concat_22
do_apply_21:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_23
do_concat_22:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_23:
    str x0, [sp, #-16]!
    mov x0, #12
    str x0, [sp, #-16]!
    mov x0, #32
    ldr x1, [sp], #16
    adr x9, heap_buffer
    cmp x1, x9
    b.lo do_concat_25
    tst x1, #1
    b.eq do_concat_25
do_apply_24:
    bic x1, x1, #1
    ldr x2, [x1]
    ldr x9, [x1, #8]
    blr x2
    b apply_end_26
do_concat_25:
    mov x2, x0
    mov x0, x1
    mov x1, x2
    bl _concat
apply_end_26:
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_19
    adr x0, sign_id
    b cmp_end_20
cmp_true_19:
cmp_end_20:
    adr x1, t4
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, test
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_3
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #44
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_27
    adr x0, sign_id
    b cmp_end_28
cmp_true_27:
cmp_end_28:
    adr x1, t5
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, str_3
    str x0, [sp, #-16]!
    adr x0, test
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _add
    str x0, [sp, #-16]!
    mov x0, #44
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_29
    adr x0, sign_id
    b cmp_end_30
cmp_true_29:
cmp_end_30:
    adr x1, t6
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    b after_func_31_32
func_31:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x0, #1
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_33
    b or_end_34
or_right_33:
    mov x0, #0
or_end_34:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_31_32:
    // Closure for func_31
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_31
    ldr x0, [sp], #16
    bl _cons
blk_end_0:



    ldp x29, x30, [sp], #16
    ret

// --- Runtime Helpers for Composition ---

// _is_func: x0 -> x0 (1 if func, 0 if not)
// Simple heuristic: If > 4096, it's a pointer (Func). Else Number.
// (Very naive, needs tagging later)
_is_func:
    cmp x0, #4096
    b.hi .L_is_func_true
    mov x0, #0
    ret
.L_is_func_true:
    mov x0, #1
    ret

// _compose: x0=f, x1=g -> Returns Closure h(x) = g(f(x))
// Creates a closure that captures f and g.
// The code for h is _composed_impl.
_compose:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Save f(x0) and g(x1) to stack to build closure
    str x0, [sp, #-16]! // f
    str x1, [sp, #-16]! // g
    
    // Create Env list: [g, f] (cons g (cons f sign_id)) ?
    // Environment for _composed_impl needs f and g.
    // Env: [g, [f, sign_id]]
    
    adr x0, sign_id
    str x0, [sp, #-16]! // nil
    
    ldr x0, [x29, #-16] // Load f
    ldr x1, [sp], #16   // Pop nil
    bl _cons            // x0 = [f, nil]
    str x0, [sp, #-16]! // Push env
    
    ldr x0, [x29, #-32] // Load g
    ldr x1, [sp], #16   // Pop env
    bl _cons            // x0 = [g, [f, nil]]
    
    // Create Closure: [_composed_impl, Env]
    str x0, [sp, #-16]! // Env
    adr x0, _composed_impl
    ldr x1, [sp], #16   // Env
    bl _cons            // Closure
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _composed_impl: x0=Arg. Env=[g, [f, nil]]
// Logic: g( f(Arg) )
_composed_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Save Arg
    str x0, [sp, #-16]!
    
    str x9, [sp, #-16]! // Save Env to Stack (local var 1)
    
    // 1. Call f(Arg)
    // We need f.
    // Env -> [g, rest]. rest -> [f, nil].
    ldr x10, [x9, #8] // rest = [f, nil]
    ldr x10, [x10]    // f (Closure)
    str x10, [sp, #-16]! // Save f
    
    // Prepare Call to f
    // x0 is Arg (already in x0)
    // closure in x10
    // Unpack f
    mov x9, x10
    ldr x10, [x9]     // Code
    ldr x9, [x9, #8]  // f's Env
    blr x10           // Call f(Arg) -> returns result in x0
    
    // 2. Call g(Result)
    // Result is in x0.
    // Load g from saved Env (at [sp, #16])
    ldr x9, [sp, #16] // Reload 'Env' (which was saved at start)
    
    // Reload Env
    ldr x11, [sp, #16] // Env
    ldr x10, [x11]     // g (Closure)
    
    // Unpack g
    mov x9, x10
    ldr x10, [x9]     // Code
    ldr x9, [x9, #8]  // g's Env
    blr x10           // Call g(f(Arg)) -> returns result
    
    // Clean up stack
    add sp, sp, #32 // Pop f, Env.
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _pow: x0 (base), x1 (exp) -> x0 (result)
_pow:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    // Check if exp < 0 (Return 0 for integer pow?)
    cmp x1, #0
    b.lt .L_pow_zero 
    mov x2, #1        // result = 1
    mov x3, x0        // base
    mov x4, x1        // exp

.L_pow_loop:
    cbz x4, .L_pow_done
    tst x4, #1
    b.eq .L_pow_square
    mul x2, x2, x3
.L_pow_square:
    lsr x4, x4, #1
    mul x3, x3, x3
    b .L_pow_loop

.L_pow_zero:
    mov x2, #0
.L_pow_done:
    mov x0, x2
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret

// _print_int: x0 = integer
// Prints integer to stdout
_print_int:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Handle 0 explicitly
    cmp x0, #0
    b.ne .L_print_int_not_zero
    
    // Print "0"
    mov x0, #1 // stdout
    adr x1, .L_str_zero
    mov x2, #1 // len
    mov x8, #64 // write
    svc #0
    
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
    
.L_print_int_not_zero:
    // We need a buffer. Use stack.
    // Max 64-bit int is ~20 digits.
    sub sp, sp, #64         // Alloc 64 bytes
    mov x9, sp              // buffer start
    add x9, x9, #63         // buffer end
    strb wzr, [x9]          // null terminate? Not needed for write syscall if we know len.
    sub x9, x9, #1          // Move back
    
    mov x10, #10            // divisor
    mov x11, x0             // number
    
    // Loop
.L_print_int_loop:
    udiv x12, x11, x10      // q = n / 10
    msub x13, x12, x10, x11 // r = n - q * 10
    
    add w13, w13, #48       // '0'
    strb w13, [x9]
    sub x9, x9, #1
    
    mov x11, x12
    cbnz x11, .L_print_int_loop
    
    // Print
    add x1, x9, #1          // Start address
    
    // Length = (sp + 63) - (x9 + 1) + 1?
    // End is sp+63.
    // Start is x1.
    // Len = (sp+63) - x1.
    mov x2, sp
    add x2, x2, #63
    sub x2, x2, x1
    add x2, x2, #1          // Fix length? No.
    // If end=100, start=100. Len = 100-100+1 = 1.
    // Wait. sp+63 is the last written byte.
    // x1 is the first written byte.
    // Length is (last - first) + 1. Correct.
    
    mov x0, #1 // stdout
    mov x8, #64 // write
    svc #0
    
    add sp, sp, #64
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
    
.L_str_zero:
    .ascii "0"

.bss
test: .quad 0
t1: .quad 0
t2: .quad 0
t3: .quad 0
t4: .quad 0
t5: .quad 0
t6: .quad 0


_sys_write:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    // fd is in x0
    // Create Closure [_sys_write_2, [fd, nil]]
    
    // 1. Env = [fd, nil]
    stp x0, x1, [sp, #-16]! // Save regs
    mov x1, x0 // Car = fd
    adr x0, sign_id // Cdr = nil
    // Swap for _cons(car=x0, cdr=x1)? No _cons(x0, x1) usually.
    // Let's assume _cons(head=x0, tail=x1)
    mov x2, x0 // nil
    mov x0, x1 // fd
    mov x1, x2 // nil
    bl _cons
    // x0 is Env
    
    // 2. Closure = [_sys_write_2, Env]
    mov x1, x0 // Env
    adr x0, _sys_write_2 // Code
    bl _cons
    
    ldp x0, x1, [sp], #16 // Restore (garbage)
    ldp x29, x30, [sp], #16
    ret

_sys_write_2:
    // x0 = buf
    // Env = [fd, nil]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // New Env needs to capture buf AND fd.
    // Current Env (in x9 usually? No, apply passes Code in x10, Env in x9)
    // We need to fetch fd from Old Env.
    // Old Env = [fd, nil]
    // Car(OldEnv) = fd.
    
    stp x0, x9, [sp, #-16]! // Save buf, OldEnv
    
    ldr x1, [x9] // Load fd from OldEnv (Car)
    // We want NewEnv = [len?, [buf, [fd, nil]]] ? 
    // No, we are building up.
    // Result of this function is Closure [_sys_write_3, [buf, fd]]
    
    // Let's make Env = [buf, fd] (simplified list)
    // x0 combined with fd.
    
    // x0 = buf (saved)
    // x1 = fd (loaded)
    
    // Create [buf, fd]
    // Step 1: Create [fd, nil] (Recreate? Or reuse OldEnv?)
    // OldEnv IS [fd, nil]. So we can reuse it as Tail!
    // So NewEnv = Cons(buf, OldEnv)
    
    ldr x0, [sp] // Restore buf
    ldr x1, [sp, #8] // Restore OldEnv
    bl _cons
    // x0 is NewEnv [buf, [fd, nil]]
    
    // Closure
    mov x1, x0 // Env
    adr x0, _sys_write_3 // Code
    bl _cons
    
    ldp x0, x9, [sp], #16
    ldp x29, x30, [sp], #16
    ret

_sys_write_3:
    // x0 = len
    // Env = [buf, [fd, nil]]
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x2, x0 // arg3: len
    
    // Extract buf, fd from Env (x9)
    ldr x1, [x9] // buf (Car)
    ldr x9, [x9, #8] // Tail [fd, nil]
    ldr x0, [x9] // fd (Car)
    
    // Now x0=fd, x1=buf, x2=len
    
    mov x8, #64 // sys_write
    svc #0
    
    // Return result (usually 0 or written bytes)
    // x0 has result.
    
    ldp x29, x30, [sp], #16
    ret
    


// Intrinsic: __sys_brk(addr) -> addr
// Usage: __sys_brk 0 (get current), __sys_brk new_addr (alloc)
// Returns CLOSURE
_sys_brk:
    // Create Closure [_sys_brk_impl, nil]
    stp x29, x30, [sp, # - 16]!
    mov x29, sp
    
    adr x0, sign_id // nil
    str x0, [sp, # - 16]!
    adr x1, _sys_brk_impl
    ldr x0, [sp], #16
    bl _cons
    
    mov sp, x29
    ldp x29, x30, [sp], #16
ret

_sys_brk_impl:
    // x0 is Arg (addr). Env is nil (ignored).
    stp x29, x30, [sp, # - 16]!
    mov x29, sp
    
    mov x8, #214 // brk
    svc #0
    
    mov sp, x29
    ldp x29, x30, [sp], #16
ret


.data
.balign 8
.global _str_start
_str_start:
str_3:
    .asciz "12"
str_0:
    .asciz "test"
str_1:
    .asciz "test123"
str_2:
    .asciz "123test"

.global _str_end
_str_end:
