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

    mov x0, #0
    str x0, [sp, #-16]!
    mov x0, #3
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_1
    adr x0, sign_id
    b cmp_end_2
cmp_true_1:
    mov x0, x1
cmp_end_2:
    cmp x0, #4096
    b.hi print_str_4
print_num_3:
    bl _print_int
    b print_done_5
print_str_4:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_6:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_7
    add x2, x2, #1
    b strlen_6
strlen_done_7:
    mov x8, #64      // syscall write
    svc #0
print_done_5:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #0
    str x0, [sp, #-16]!
    mov x0, #3
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_8
    adr x0, sign_id
    b cmp_end_9
cmp_true_8:
    mov x0, x1
cmp_end_9:
    cmp x0, #4096
    b.hi print_str_11
print_num_10:
    bl _print_int
    b print_done_12
print_str_11:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_13:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_14
    add x2, x2, #1
    b strlen_13
strlen_done_14:
    mov x8, #64      // syscall write
    svc #0
print_done_12:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #1
    str x0, [sp, #-16]!
    mov x0, #5
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_17
    adr x0, sign_id
    b cmp_end_18
cmp_true_17:
    mov x0, x1
cmp_end_18:
    str x0, [sp, #-16]!
    mov x0, #10
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt cmp_true_15
    adr x0, sign_id
    b cmp_end_16
cmp_true_15:
cmp_end_16:
    cmp x0, #4096
    b.hi print_str_20
print_num_19:
    bl _print_int
    b print_done_21
print_str_20:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_22:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_23
    add x2, x2, #1
    b strlen_22
strlen_done_23:
    mov x8, #64      // syscall write
    svc #0
print_done_21:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #10
    str x0, [sp, #-16]!
    mov x0, #3
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_26
    adr x0, sign_id
    b cmp_end_27
cmp_true_26:
    mov x0, x1
cmp_end_27:
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt cmp_true_24
    adr x0, sign_id
    b cmp_end_25
cmp_true_24:
cmp_end_25:
    cmp x0, #4096
    b.hi print_str_29
print_num_28:
    bl _print_int
    b print_done_30
print_str_29:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_31:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_32
    add x2, x2, #1
    b strlen_31
strlen_done_32:
    mov x8, #64      // syscall write
    svc #0
print_done_30:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #6
    str x0, [sp, #-16]!
    mov x0, #6
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_35
    adr x0, sign_id
    b cmp_end_36
cmp_true_35:
    mov x0, x1
cmp_end_36:
    str x0, [sp, #-16]!
    mov x0, #6
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_33
    adr x0, sign_id
    b cmp_end_34
cmp_true_33:
cmp_end_34:
    cmp x0, #4096
    b.hi print_str_38
print_num_37:
    bl _print_int
    b print_done_39
print_str_38:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_40:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_41
    add x2, x2, #1
    b strlen_40
strlen_done_41:
    mov x8, #64      // syscall write
    svc #0
print_done_39:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #6
    str x0, [sp, #-16]!
    mov x0, #6
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_44
    adr x0, sign_id
    b cmp_end_45
cmp_true_44:
    mov x0, x1
cmp_end_45:
    str x0, [sp, #-16]!
    mov x0, #3
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_42
    adr x0, sign_id
    b cmp_end_43
cmp_true_42:
cmp_end_43:
    cmp x0, #4096
    b.hi print_str_47
print_num_46:
    bl _print_int
    b print_done_48
print_str_47:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_49:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_50
    add x2, x2, #1
    b strlen_49
strlen_done_50:
    mov x8, #64      // syscall write
    svc #0
print_done_48:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #6
    str x0, [sp, #-16]!
    mov x0, #3
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_53
    adr x0, sign_id
    b cmp_end_54
cmp_true_53:
    mov x0, x1
cmp_end_54:
    str x0, [sp, #-16]!
    mov x0, #6
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_51
    adr x0, sign_id
    b cmp_end_52
cmp_true_51:
cmp_end_52:
    cmp x0, #4096
    b.hi print_str_56
print_num_55:
    bl _print_int
    b print_done_57
print_str_56:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_58:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_59
    add x2, x2, #1
    b strlen_58
strlen_done_59:
    mov x8, #64      // syscall write
    svc #0
print_done_57:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    mov x0, #3
    str x0, [sp, #-16]!
    mov x0, #6
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_62
    adr x0, sign_id
    b cmp_end_63
cmp_true_62:
    mov x0, x1
cmp_end_63:
    str x0, [sp, #-16]!
    mov x0, #6
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_60
    adr x0, sign_id
    b cmp_end_61
cmp_true_60:
cmp_end_61:
    cmp x0, #4096
    b.hi print_str_65
print_num_64:
    bl _print_int
    b print_done_66
print_str_65:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_67:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_68
    add x2, x2, #1
    b strlen_67
strlen_done_68:
    mov x8, #64      // syscall write
    svc #0
print_done_66:
    adr x0, sign_id
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

