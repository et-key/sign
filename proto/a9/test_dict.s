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

    adr x0, sign_id
    str x0, [sp, #-16]!
    b after_func_1_2
func_1:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str_0
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_7
    adr x0, sign_id
    b cmp_end_8
cmp_true_7:
cmp_end_8:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_5
    mov x0, #100
    b cond_end_6
cond_false_5:
    adr x0, sign_id
cond_end_6:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_3
    b or_end_4
or_right_3:
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str_1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_13
    adr x0, sign_id
    b cmp_end_14
cmp_true_13:
cmp_end_14:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_11
    mov x0, #200
    b cond_end_12
cond_false_11:
    adr x0, sign_id
cond_end_12:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_9
    b or_end_10
or_right_9:
    adr x0, sign_id
or_end_10:
or_end_4:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_func_1_2:
    // Closure for func_1
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, func_1
    ldr x0, [sp], #16
    bl _cons
    orr x0, x0, #1 // Tag closure
    ldr x9, [sp], #16
    adr x1, sign_id
    cmp x9, x1
    b.eq id_morphism_18
    tst x9, #1
    b.eq do_concat_17
    tst x0, #1
    b.ne do_compose_15
do_apply_16:
    eor x9, x9, #1
    ldr x1, [x9]
    ldr x9, [x9, #8]
    blr x1
    b apply_end_19
do_compose_15:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_19
do_concat_17:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_19
id_morphism_18:
    b apply_end_19
apply_end_19:
    adr x1, dict
    str x0, [x1]
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, dict
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_0
    ldr x9, [sp], #16
    adr x1, sign_id
    cmp x9, x1
    b.eq id_morphism_23
    tst x9, #1
    b.eq do_concat_22
    tst x0, #1
    b.ne do_compose_20
do_apply_21:
    eor x9, x9, #1
    ldr x1, [x9]
    ldr x9, [x9, #8]
    blr x1
    b apply_end_24
do_compose_20:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_24
do_concat_22:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_24
id_morphism_23:
    b apply_end_24
apply_end_24:
    adr x9, sign_id
    cmp x0, x9
    b.eq print_done_27
    cmp x0, #4096
    b.hi print_str_26
print_num_25:
    bl _print_int
    b print_done_27
print_str_26:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_28:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_29
    add x2, x2, #1
    b strlen_28
strlen_done_29:
    mov x8, #64      // syscall write
    svc #0
print_done_27:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, dict
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_1
    ldr x9, [sp], #16
    adr x1, sign_id
    cmp x9, x1
    b.eq id_morphism_33
    tst x9, #1
    b.eq do_concat_32
    tst x0, #1
    b.ne do_compose_30
do_apply_31:
    eor x9, x9, #1
    ldr x1, [x9]
    ldr x9, [x9, #8]
    blr x1
    b apply_end_34
do_compose_30:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_34
do_concat_32:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_34
id_morphism_33:
    b apply_end_34
apply_end_34:
    adr x9, sign_id
    cmp x0, x9
    b.eq print_done_37
    cmp x0, #4096
    b.hi print_str_36
print_num_35:
    bl _print_int
    b print_done_37
print_str_36:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_38:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_39
    add x2, x2, #1
    b strlen_38
strlen_done_39:
    mov x8, #64      // syscall write
    svc #0
print_done_37:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, dict
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_0
    ldr x9, [sp], #16
    adr x1, sign_id
    cmp x9, x1
    b.eq id_morphism_43
    tst x9, #1
    b.eq do_concat_42
    tst x0, #1
    b.ne do_compose_40
do_apply_41:
    eor x9, x9, #1
    ldr x1, [x9]
    ldr x9, [x9, #8]
    blr x1
    b apply_end_44
do_compose_40:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_44
do_concat_42:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_44
id_morphism_43:
    b apply_end_44
apply_end_44:
    adr x9, sign_id
    cmp x0, x9
    b.eq print_done_47
    cmp x0, #4096
    b.hi print_str_46
print_num_45:
    bl _print_int
    b print_done_47
print_str_46:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_48:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_49
    add x2, x2, #1
    b strlen_48
strlen_done_49:
    mov x8, #64      // syscall write
    svc #0
print_done_47:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, dict
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_2
    ldr x9, [sp], #16
    adr x1, sign_id
    cmp x9, x1
    b.eq id_morphism_53
    tst x9, #1
    b.eq do_concat_52
    tst x0, #1
    b.ne do_compose_50
do_apply_51:
    eor x9, x9, #1
    ldr x1, [x9]
    ldr x9, [x9, #8]
    blr x1
    b apply_end_54
do_compose_50:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_54
do_concat_52:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_54
id_morphism_53:
    b apply_end_54
apply_end_54:
    adr x9, sign_id
    cmp x0, x9
    b.eq print_done_57
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
    b after_new_dict_impl_60
new_dict_impl:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    str x0, [sp, #-16]!
    adr x0, str_2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq cmp_true_65
    adr x0, sign_id
    b cmp_end_66
cmp_true_65:
cmp_end_66:
    adr x9, sign_id
    cmp x0, x9
    b.eq cond_false_63
    mov x0, #300
    b cond_end_64
cond_false_63:
    adr x0, sign_id
cond_end_64:
    adr x9, sign_id
    cmp x0, x9
    b.eq or_right_61
    b or_end_62
or_right_61:
    adr x0, dict
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ldr x0, [x29, #-32]
    ldr x9, [sp], #16
    adr x1, sign_id
    cmp x9, x1
    b.eq id_morphism_70
    tst x9, #1
    b.eq do_concat_69
    tst x0, #1
    b.ne do_compose_67
do_apply_68:
    eor x9, x9, #1
    ldr x1, [x9]
    ldr x9, [x9, #8]
    blr x1
    b apply_end_71
do_compose_67:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_71
do_concat_69:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_71
id_morphism_70:
    b apply_end_71
apply_end_71:
or_end_62:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_new_dict_impl_60:
    // Closure for new_dict_impl
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x1, new_dict_impl
    ldr x0, [sp], #16
    bl _cons
    orr x0, x0, #1 // Tag closure
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, new_dict
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_2
    ldr x9, [sp], #16
    adr x1, sign_id
    cmp x9, x1
    b.eq id_morphism_75
    tst x9, #1
    b.eq do_concat_74
    tst x0, #1
    b.ne do_compose_72
do_apply_73:
    eor x9, x9, #1
    ldr x1, [x9]
    ldr x9, [x9, #8]
    blr x1
    b apply_end_76
do_compose_72:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_76
do_concat_74:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_76
id_morphism_75:
    b apply_end_76
apply_end_76:
    adr x9, sign_id
    cmp x0, x9
    b.eq print_done_79
    cmp x0, #4096
    b.hi print_str_78
print_num_77:
    bl _print_int
    b print_done_79
print_str_78:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_80:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_81
    add x2, x2, #1
    b strlen_80
strlen_done_81:
    mov x8, #64      // syscall write
    svc #0
print_done_79:
    adr x0, sign_id
    adr x9, sign_id
    cmp x0, x9
    b.ne blk_end_0
    adr x0, new_dict
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_0
    ldr x9, [sp], #16
    adr x1, sign_id
    cmp x9, x1
    b.eq id_morphism_85
    tst x9, #1
    b.eq do_concat_84
    tst x0, #1
    b.ne do_compose_82
do_apply_83:
    eor x9, x9, #1
    ldr x1, [x9]
    ldr x9, [x9, #8]
    blr x1
    b apply_end_86
do_compose_82:
    mov x1, x0
    mov x0, x9
    bl _compose
    b apply_end_86
do_concat_84:
    mov x1, x0
    mov x0, x9
    bl _concat
    b apply_end_86
id_morphism_85:
    b apply_end_86
apply_end_86:
    adr x9, sign_id
    cmp x0, x9
    b.eq print_done_89
    cmp x0, #4096
    b.hi print_str_88
print_num_87:
    bl _print_int
    b print_done_89
print_str_88:
    // Magic IO Write to FD 1
    mov x1, x0       // buf = RHS
    mov x0, #1   // fd
    mov x2, #0       // len
strlen_90:
    ldrb w3, [x1, x2]
    cbz w3, strlen_done_91
    add x2, x2, #1
    b strlen_90
strlen_done_91:
    mov x8, #64      // syscall write
    svc #0
print_done_89:
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
dict: .quad 0
new_dict: .quad 0


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
str_0:
    .asciz "a"
str_1:
    .asciz "b"
str_2:
    .asciz "c"
