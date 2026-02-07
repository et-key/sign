.global _start
.text
_start:
    adr x0, heap_buffer
    adr x1, heap_ptr
    str x0, [x1]
    ; Global Define TOK_EOF = -1
    ; Global Define TOK_NUM = 1
    ; Global Define TOK_ID = 2
    ; Global Define TOK_OP = 3
    ; Global Define TOK_INDENT = 4
    ; Global Define TOK_DEDENT = 5
    ; Global Define EOF = -1
    ; Global Define CHAR_SPACE = 32
    ; Global Define CHAR_NEWLINE = 10
    ; Global Define CHAR_TAB = 9
    ; Global Define CHAR_PLUS = 43
    ; Global Define CHAR_MINUS = 45
    ; Global Define CHAR_0 = 48
    ; Global Define CHAR_9 = 57
    b after_is_digit_0
is_digit:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x0, x0
    str x0, [sp, #-16]!
    adr x0, CHAR_0
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge true_3
    adr x0, sign_id ; Unit (False)
    b end_4
true_3:
    mov x0, x1 ; Return RHS
end_4:
    adr x9, sign_id
    cmp x0, x9
    b.eq and_fail_1
    mov x0, x0
    str x0, [sp, #-16]!
    adr x0, CHAR_9
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.le true_5
    adr x0, sign_id ; Unit (False)
    b end_6
true_5:
    mov x0, x1 ; Return RHS
end_6:
    b and_end_2
and_fail_1:
    adr x0, sign_id
and_end_2:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_digit_0:
    adr x0, is_digit
    b after_is_space_7
is_space:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    mov x0, x0
    str x0, [sp, #-16]!
    adr x0, CHAR_SPACE
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_12
    adr x0, sign_id ; Unit (False)
    b end_13
true_12:
    mov x0, x1 ; Return RHS
end_13:
    adr x9, sign_id
    cmp x0, x9
    b.ne or_succ_10
    mov x0, x0
    str x0, [sp, #-16]!
    adr x0, CHAR_NEWLINE
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_14
    adr x0, sign_id ; Unit (False)
    b end_15
true_14:
    mov x0, x1 ; Return RHS
end_15:
    b or_end_11
or_succ_10:
or_end_11:
    adr x9, sign_id
    cmp x0, x9
    b.ne or_succ_8
    mov x0, x0
    str x0, [sp, #-16]!
    adr x0, CHAR_TAB
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_16
    adr x0, sign_id ; Unit (False)
    b end_17
true_16:
    mov x0, x1 ; Return RHS
end_17:
    b or_end_9
or_succ_8:
or_end_9:
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_is_space_7:
    adr x0, is_space
    b after_read_all_18
read_all:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_read_all_18:
    adr x0, read_all
    adr x0, _read_char
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, c
    str x0, [x1]
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, EOF
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_21
    adr x0, sign_id ; Unit (False)
    b end_22
true_21:
    mov x0, x1 ; Return RHS
end_22:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_19
    adr x0, sign_id
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_0
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_20
case_fail_19:
    adr x0, sign_id
case_end_20:
    adr x0, str_1
    adr x0, read_all
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, rest
    str x0, [x1]
    adr x0, c
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    ; Global Define TOK_INDENT = 4
    ; Global Define TOK_DEDENT = 5
    b after_count_indent_23
count_indent:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_count_indent_23:
    adr x0, count_indent
    adr x0, chars
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_26
    adr x0, sign_id ; Unit (False)
    b end_27
true_26:
    mov x0, x1 ; Return RHS
end_27:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_24
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    b case_end_25
case_fail_24:
    adr x0, sign_id
case_end_25:
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, head
    str x0, [x1]
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, tail
    str x0, [x1]
    adr x0, is_space
    str x0, [sp, #-16]!  ; Push Func
    adr x0, head
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_28
    adr x0, str_2
    str x0, [sp, #-16]!  ; Push Func
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, CHAR_NEWLINE
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_33
    adr x0, sign_id ; Unit (False)
    b end_34
true_33:
    mov x0, x1 ; Return RHS
end_34:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_31
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!  ; Push Func
    adr x0, res
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_35
    adr x0, count_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tail
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, cnt
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_37
    adr x0, res
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_39
    adr x0, res
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, cnt
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_40
case_fail_39:
    adr x0, sign_id
case_end_40:
    b case_end_38
case_fail_37:
    adr x0, sign_id
case_end_38:
    b case_end_36
case_fail_35:
    adr x0, sign_id
case_end_36:
    b case_end_32
case_fail_31:
    adr x0, sign_id
case_end_32:
match_end_30:
    b case_end_29
case_fail_28:
    adr x0, sign_id
case_end_29:
    mov x0, #0
    str x0, [sp, #-16]!
    adr x0, chars
    ldr x1, [sp], #16
    bl _cons
    b after_tokenize_indent_41
tokenize_indent:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_tokenize_indent_41:
    adr x0, tokenize_indent
    adr x0, chars
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_44
    adr x0, sign_id ; Unit (False)
    b end_45
true_44:
    mov x0, x1 ; Return RHS
end_45:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_42
    adr x0, str_3
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_4
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_43
case_fail_42:
    adr x0, sign_id
case_end_43:
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, head
    str x0, [x1]
    adr x0, str_5
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, CHAR_SPACE
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_48
    adr x0, sign_id ; Unit (False)
    b end_49
true_48:
    mov x0, x1 ; Return RHS
end_49:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_46
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_47
case_fail_46:
    adr x0, sign_id
case_end_47:
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, CHAR_TAB
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_52
    adr x0, sign_id ; Unit (False)
    b end_53
true_52:
    mov x0, x1 ; Return RHS
end_53:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_50
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_51
case_fail_50:
    adr x0, sign_id
case_end_51:
    adr x0, str_6
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, CHAR_NEWLINE
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_56
    adr x0, sign_id ; Unit (False)
    b end_57
true_56:
    mov x0, x1 ; Return RHS
end_57:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_54
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, res
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_58
    adr x0, count_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tail
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, new_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_60
    adr x0, res
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_62
    adr x0, res
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_7
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_8
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_9
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, new_indent
    str x0, [sp, #-16]!
    adr x0, current_indent
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.gt true_66
    adr x0, sign_id ; Unit (False)
    b end_67
true_66:
    mov x0, x1 ; Return RHS
end_67:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_64
    adr x0, str_10
    str x0, [sp, #-16]!  ; Push Func
    adr x0, TOK_INDENT
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, new_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!  ; Push Func
    adr x0, new_indent
    str x0, [sp, #-16]!
    adr x0, current_indent
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.lt true_70
    adr x0, sign_id ; Unit (False)
    b end_71
true_70:
    mov x0, x1 ; Return RHS
end_71:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_68
    adr x0, str_11
    str x0, [sp, #-16]!  ; Push Func
    adr x0, TOK_DEDENT
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, new_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_12
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tokenize_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_69
case_fail_68:
    adr x0, sign_id
case_end_69:
    b case_end_65
case_fail_64:
    adr x0, sign_id
case_end_65:
    b case_end_63
case_fail_62:
    adr x0, sign_id
case_end_63:
    b case_end_61
case_fail_60:
    adr x0, sign_id
case_end_61:
    b case_end_59
case_fail_58:
    adr x0, sign_id
case_end_59:
    adr x1, tail
    str x0, [x1]
    b case_end_55
case_fail_54:
    adr x0, sign_id
case_end_55:
    adr x0, str_13
    adr x0, str_14
    adr x0, str_15
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, CHAR_PLUS
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_74
    adr x0, sign_id ; Unit (False)
    b end_75
true_74:
    mov x0, x1 ; Return RHS
end_75:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_72
    adr x0, TOK_OP
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_16
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    b case_end_73
case_fail_72:
    adr x0, sign_id
case_end_73:
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, CHAR_MINUS
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_78
    adr x0, sign_id ; Unit (False)
    b end_79
true_78:
    mov x0, x1 ; Return RHS
end_79:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_76
    adr x0, TOK_OP
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_17
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    b case_end_77
case_fail_76:
    adr x0, sign_id
case_end_77:
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_82
    adr x0, sign_id ; Unit (False)
    b end_83
true_82:
    mov x0, x1 ; Return RHS
end_83:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_80
    adr x0, TOK_OP
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_18
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    b case_end_81
case_fail_80:
    adr x0, sign_id
case_end_81:
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_19
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_86
    adr x0, sign_id ; Unit (False)
    b end_87
true_86:
    mov x0, x1 ; Return RHS
end_87:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_84
    adr x0, TOK_OP
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_19
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    b case_end_85
case_fail_84:
    adr x0, sign_id
case_end_85:
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_20
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_90
    adr x0, sign_id ; Unit (False)
    b end_91
true_90:
    mov x0, x1 ; Return RHS
end_91:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_88
    adr x0, TOK_OP
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_20
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    b case_end_89
case_fail_88:
    adr x0, sign_id
case_end_89:
    adr x0, head
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_21
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_94
    adr x0, sign_id ; Unit (False)
    b end_95
true_94:
    mov x0, x1 ; Return RHS
end_95:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_92
    adr x0, TOK_OP
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_21
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    b case_end_93
case_fail_92:
    adr x0, sign_id
case_end_93:
    adr x0, str_22
    adr x0, is_digit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, head
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_96
    adr x0, TOK_NUM
    ldr x0, [x0]
    str x0, [sp, #-16]!
    ; UNKNOWN OP: -
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    b case_end_97
case_fail_96:
    adr x0, sign_id
case_end_97:
    adr x0, str_23
    adr x0, head
    ldr x0, [x0]
    adr x1, id_val
    str x0, [x1]
    adr x0, TOK_ID
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, id_val
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, current_indent
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    b after_tokenize_98
tokenize:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_tokenize_98:
    adr x0, tokenize
    adr x0, tokenize_indent
    str x0, [sp, #-16]!  ; Push Func
    adr x0, chars
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #0
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ; Global Define PREC_NONE = 0
    mov x0, #1
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_18
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, PREC_ASSIGN
    str x0, [x1]
    mov x0, #2
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_19
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, PREC_FUNC
    str x0, [x1]
    mov x0, #3
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_20
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, PREC_COMPARE
    str x0, [x1]
    mov x0, #4
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_24
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, PREC_TERM
    str x0, [x1]
    mov x0, #5
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_25
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, PREC_FACTOR
    str x0, [x1]
    mov x0, #6
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_26
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, PREC_POSTFIX
    str x0, [x1]
    b after_get_precedence_99
get_precedence:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_get_precedence_99:
    adr x0, get_precedence
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_102
    adr x0, sign_id ; Unit (False)
    b end_103
true_102:
    mov x0, x1 ; Return RHS
end_103:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_100
    adr x0, PREC_ASSIGN
    ldr x0, [x0]
    b case_end_101
case_fail_100:
    adr x0, sign_id
case_end_101:
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, str_19
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_106
    adr x0, sign_id ; Unit (False)
    b end_107
true_106:
    mov x0, x1 ; Return RHS
end_107:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_104
    adr x0, PREC_FUNC
    ldr x0, [x0]
    b case_end_105
case_fail_104:
    adr x0, sign_id
case_end_105:
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, str_20
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_110
    adr x0, sign_id ; Unit (False)
    b end_111
true_110:
    mov x0, x1 ; Return RHS
end_111:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_108
    adr x0, PREC_COMPARE
    ldr x0, [x0]
    b case_end_109
case_fail_108:
    adr x0, sign_id
case_end_109:
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, str_16
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_114
    adr x0, sign_id ; Unit (False)
    b end_115
true_114:
    mov x0, x1 ; Return RHS
end_115:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_112
    adr x0, PREC_TERM
    ldr x0, [x0]
    b case_end_113
case_fail_112:
    adr x0, sign_id
case_end_113:
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, str_17
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_118
    adr x0, sign_id ; Unit (False)
    b end_119
true_118:
    mov x0, x1 ; Return RHS
end_119:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_116
    adr x0, PREC_TERM
    ldr x0, [x0]
    b case_end_117
case_fail_116:
    adr x0, sign_id
case_end_117:
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, str_27
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_122
    adr x0, sign_id ; Unit (False)
    b end_123
true_122:
    mov x0, x1 ; Return RHS
end_123:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_120
    adr x0, PREC_FACTOR
    ldr x0, [x0]
    b case_end_121
case_fail_120:
    adr x0, sign_id
case_end_121:
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, str_28
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_126
    adr x0, sign_id ; Unit (False)
    b end_127
true_126:
    mov x0, x1 ; Return RHS
end_127:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_124
    adr x0, PREC_FACTOR
    ldr x0, [x0]
    b case_end_125
case_fail_124:
    adr x0, sign_id
case_end_125:
    adr x0, op
    str x0, [sp, #-16]!
    adr x0, str_21
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_130
    adr x0, sign_id ; Unit (False)
    b end_131
true_130:
    mov x0, x1 ; Return RHS
end_131:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_128
    adr x0, PREC_POSTFIX
    ldr x0, [x0]
    b case_end_129
case_fail_128:
    adr x0, sign_id
case_end_129:
    adr x0, PREC_NONE
    ldr x0, [x0]
    ; Global Define TOK_INDENT = 4
    ; Global Define TOK_DEDENT = 5
    ; Global Define TOK_BLOCK = 6
    ; Global Define EOF = -1
    b after_parse_block_list_132
parse_block_list:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_parse_block_list_132:
    adr x0, parse_block_list
    adr x0, tokens
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_135
    adr x0, sign_id ; Unit (False)
    b end_136
true_135:
    mov x0, x1 ; Return RHS
end_136:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_133
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    b case_end_134
case_fail_133:
    adr x0, sign_id
case_end_134:
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, token
    str x0, [x1]
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, type
    str x0, [x1]
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_DEDENT
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_139
    adr x0, sign_id ; Unit (False)
    b end_140
true_139:
    mov x0, x1 ; Return RHS
end_140:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_137
    adr x0, str_29
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_142
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_143
case_fail_142:
    adr x0, sign_id
case_end_143:
match_end_141:
    b case_end_138
case_fail_137:
    adr x0, sign_id
case_end_138:
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_EOF
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_146
    adr x0, sign_id ; Unit (False)
    b end_147
true_146:
    mov x0, x1 ; Return RHS
end_147:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_144
    adr x0, str_30
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_145
case_fail_144:
    adr x0, sign_id
case_end_145:
    adr x0, str_31
    adr x0, parse_expr
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tokens
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, res
    str x0, [x1]
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, node
    str x0, [x1]
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, rest
    str x0, [x1]
    adr x0, str_32
    adr x0, parse_block_list
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, res2
    str x0, [x1]
    adr x0, res2
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, nodes
    str x0, [x1]
    adr x0, res2
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, final_rest
    str x0, [x1]
    adr x0, str_33
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, nodes
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x1, final_nodes
    str x0, [x1]
    adr x0, final_nodes
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, final_rest
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    b after_parse_atom_148
parse_atom:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_parse_atom_148:
    adr x0, parse_atom
    adr x0, tokens
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_151
    adr x0, sign_id ; Unit (False)
    b end_152
true_151:
    mov x0, x1 ; Return RHS
end_152:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_149
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_34
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_150
case_fail_149:
    adr x0, sign_id
case_end_150:
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, token
    str x0, [x1]
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, rest
    str x0, [x1]
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, type
    str x0, [x1]
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, val
    str x0, [x1]
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_NUM
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_155
    adr x0, sign_id ; Unit (False)
    b end_156
true_155:
    mov x0, x1 ; Return RHS
end_156:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_153
    adr x0, str_35
    str x0, [sp, #-16]!  ; Push Func
    adr x0, node
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_158
    adr x0, TOK_NUM
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tokens_after_num
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_160
    adr x0, rest
    ldr x0, [x0]
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_36
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, parse_postfix_loop
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, node
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tokens_after_num
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_161
case_fail_160:
    adr x0, sign_id
case_end_161:
    b case_end_159
case_fail_158:
    adr x0, sign_id
case_end_159:
match_end_157:
    b case_end_154
case_fail_153:
    adr x0, sign_id
case_end_154:
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_ID
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_164
    adr x0, sign_id ; Unit (False)
    b end_165
true_164:
    mov x0, x1 ; Return RHS
end_165:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_162
    adr x0, str_37
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_38
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_39
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, node
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_167
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!  ; Push Func
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_168
case_fail_167:
    adr x0, sign_id
case_end_168:
match_end_166:
    b case_end_163
case_fail_162:
    adr x0, sign_id
case_end_163:
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_INDENT
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_171
    adr x0, sign_id ; Unit (False)
    b end_172
true_171:
    mov x0, x1 ; Return RHS
end_172:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_169
    adr x0, str_40
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_41
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, res
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_174
    adr x0, parse_block_list
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, nodes
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_176
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest_after_block
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_178
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_42
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, node
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_180
    adr x0, TOK_BLOCK
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, nodes
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!  ; Push Func
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, rest_after_block
    ldr x1, [sp], #16
    bl _cons
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    b case_end_181
case_fail_180:
    adr x0, sign_id
case_end_181:
    b case_end_179
case_fail_178:
    adr x0, sign_id
case_end_179:
    b case_end_177
case_fail_176:
    adr x0, sign_id
case_end_177:
    b case_end_175
case_fail_174:
    adr x0, sign_id
case_end_175:
match_end_173:
    b case_end_170
case_fail_169:
    adr x0, sign_id
case_end_170:
    adr x0, str_43
    adr x0, str_44
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, rest
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    b after_parse_postfix_loop_182
parse_postfix_loop:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_parse_postfix_loop_182:
    adr x0, parse_postfix_loop
    adr x0, tokens
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_185
    adr x0, sign_id ; Unit (False)
    b end_186
true_185:
    mov x0, x1 ; Return RHS
end_186:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_183
    adr x0, lhs
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    b case_end_184
case_fail_183:
    adr x0, sign_id
case_end_184:
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, token
    str x0, [x1]
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, type
    str x0, [x1]
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, val
    str x0, [x1]
    adr x0, str_45
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_21
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_187
    adr x0, sign_id ; Unit (False)
    b end_188
true_187:
    mov x0, x1 ; Return RHS
end_188:
    adr x1, is_postfix
    str x0, [x1]
    adr x0, is_postfix
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_191
    adr x0, sign_id ; Unit (False)
    b end_192
true_191:
    mov x0, x1 ; Return RHS
end_192:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_189
    adr x0, lhs
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_46
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_190
case_fail_189:
    adr x0, sign_id
case_end_190:
    adr x0, str_47
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, rest
    str x0, [x1]
    adr x0, str_48
    adr x0, str_49
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, lhs
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    adr x1, new_lhs
    str x0, [x1]
    adr x0, str_50
    adr x0, parse_postfix_loop
    str x0, [sp, #-16]!  ; Push Func
    adr x0, new_lhs
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b after_parse_expr_climb_193
parse_expr_climb:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_parse_expr_climb_193:
    adr x0, parse_expr_climb
    adr x0, tokens
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_196
    adr x0, sign_id ; Unit (False)
    b end_197
true_196:
    mov x0, x1 ; Return RHS
end_197:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_194
    adr x0, lhs
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    b case_end_195
case_fail_194:
    adr x0, sign_id
case_end_195:
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, token
    str x0, [x1]
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, type
    str x0, [x1]
    adr x0, str_51
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_OP
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_200
    adr x0, sign_id ; Unit (False)
    b end_201
true_200:
    mov x0, x1 ; Return RHS
end_201:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_198
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, prec
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_202
    adr x0, get_precedence
    str x0, [sp, #-16]!  ; Push Func
    adr x0, op
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_52
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, should_climb
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_204
    adr x0, prec
    str x0, [sp, #-16]!
    adr x0, min_prec
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.ge true_208
    adr x0, sign_id ; Unit (False)
    b end_209
true_208:
    mov x0, x1 ; Return RHS
end_209:
    str x0, [sp, #-16]!  ; Push Func
    adr x0, should_climb
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_210
    adr x0, sign_id ; Unit (False)
    b end_211
true_210:
    mov x0, x1 ; Return RHS
end_211:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_206
    adr x0, lhs
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x1, [sp], #16
    bl _cons
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_53
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_54
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_212
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_55
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, next_prec
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_214
    adr x0, prec
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    add x0, x1, x0
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_56
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, res_rhs
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_216
    adr x0, parse_atom
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rhs_atom
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_218
    adr x0, res_rhs
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest_after_atom
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_220
    adr x0, res_rhs
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_57
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, res_tree
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_222
    adr x0, parse_expr_climb
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rhs_atom
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, next_prec
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest_after_atom
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rhs
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_224
    adr x0, res_tree
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, final_rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_226
    adr x0, res_tree
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_58
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_59
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, new_lhs
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_228
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, lhs
    str x0, [sp, #-16]!
    adr x0, rhs
    str x0, [sp, #-16]!
    adr x0, sign_id
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_60
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, parse_expr_climb
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, new_lhs
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, min_prec
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, final_rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    ldr x1, [sp], #16
    bl _cons
    b case_end_229
case_fail_228:
    adr x0, sign_id
case_end_229:
    b case_end_227
case_fail_226:
    adr x0, sign_id
case_end_227:
    b case_end_225
case_fail_224:
    adr x0, sign_id
case_end_225:
    b case_end_223
case_fail_222:
    adr x0, sign_id
case_end_223:
    b case_end_221
case_fail_220:
    adr x0, sign_id
case_end_221:
    b case_end_219
case_fail_218:
    adr x0, sign_id
case_end_219:
    b case_end_217
case_fail_216:
    adr x0, sign_id
case_end_217:
    b case_end_215
case_fail_214:
    adr x0, sign_id
case_end_215:
    b case_end_213
case_fail_212:
    adr x0, sign_id
case_end_213:
    b case_end_207
case_fail_206:
    adr x0, sign_id
case_end_207:
    b case_end_205
case_fail_204:
    adr x0, sign_id
case_end_205:
    b case_end_203
case_fail_202:
    adr x0, sign_id
case_end_203:
    adr x1, op
    str x0, [x1]
    b case_end_199
case_fail_198:
    adr x0, sign_id
case_end_199:
    adr x0, str_61
    adr x0, lhs
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x1, [sp], #16
    bl _cons
    b after_parse_expr_230
parse_expr:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_parse_expr_230:
    adr x0, parse_expr
    adr x0, str_62
    adr x0, parse_atom
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tokens
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, res
    str x0, [x1]
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, lhs
    str x0, [x1]
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, rest
    str x0, [x1]
    adr x0, str_63
    adr x0, parse_expr_climb
    str x0, [sp, #-16]!  ; Push Func
    adr x0, lhs
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, PREC_NONE
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b after_parse_block_231
parse_block:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_parse_block_231:
    adr x0, parse_block
    adr x0, tokens
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_234
    adr x0, sign_id ; Unit (False)
    b end_235
true_234:
    mov x0, x1 ; Return RHS
end_235:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_232
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, sign_id
    ldr x1, [sp], #16
    bl _cons
    b case_end_233
case_fail_232:
    adr x0, sign_id
case_end_233:
    adr x0, str_64
    adr x0, tokens
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, token
    str x0, [x1]
    adr x0, token
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, type
    str x0, [x1]
    adr x0, type
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_EOF
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_238
    adr x0, sign_id ; Unit (False)
    b end_239
true_238:
    mov x0, x1 ; Return RHS
end_239:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_236
    adr x0, sign_id
    str x0, [sp, #-16]!
    adr x0, tokens
    ldr x1, [sp], #16
    bl _cons
    b case_end_237
case_fail_236:
    adr x0, sign_id
case_end_237:
    adr x0, str_31
    adr x0, parse_expr
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tokens
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, res
    str x0, [x1]
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, node
    str x0, [x1]
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, rest
    str x0, [x1]
    adr x0, str_32
    adr x0, parse_block
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rest
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, res2
    str x0, [x1]
    adr x0, res2
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, nodes
    str x0, [x1]
    adr x0, res2
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, final_rest
    str x0, [x1]
    adr x0, str_65
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, nodes
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    adr x1, final_nodes
    str x0, [x1]
    adr x0, final_nodes
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, final_rest
    ldr x0, [x0]
    ldr x1, [sp], #16
    bl _cons
    ; Global Define TOK_NUM = 1
    ; Global Define TOK_BLOCK = 6
    b after_emit_240
emit:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_emit_240:
    adr x0, emit
    adr x0, _print_str
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, _print_char
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #10
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b after_compile_node_241
compile_node:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_compile_node_241:
    adr x0, compile_node
    adr x0, str_66
    adr x0, str_67
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_244
    adr x0, sign_id ; Unit (False)
    b end_245
true_244:
    mov x0, x1 ; Return RHS
end_245:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_242
    adr x0, sign_id
    b case_end_243
case_fail_242:
    adr x0, sign_id
case_end_243:
    adr x0, str_68
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, op
    str x0, [x1]
    adr x0, str_69
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_BLOCK
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_248
    adr x0, sign_id ; Unit (False)
    b end_249
true_248:
    mov x0, x1 ; Return RHS
end_249:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_246
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, compile_block
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, nodes
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, nodes
    str x0, [x1]
    b case_end_247
case_fail_246:
    adr x0, sign_id
case_end_247:
    adr x0, str_70
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, TOK_NUM
    ldr x0, [x0]
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_252
    adr x0, sign_id ; Unit (False)
    b end_253
true_252:
    mov x0, x1 ; Return RHS
end_253:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_250
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, emit
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_71
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, _print_str
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, val
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_72
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_73
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_74
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_75
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_76
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_77
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_78
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_79
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_80
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_256
    adr x0, sign_id ; Unit (False)
    b end_257
true_256:
    mov x0, x1 ; Return RHS
end_257:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_254
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_81
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #2
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_260
    adr x0, sign_id ; Unit (False)
    b end_261
true_260:
    mov x0, x1 ; Return RHS
end_261:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_258
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_82
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #3
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_264
    adr x0, sign_id ; Unit (False)
    b end_265
true_264:
    mov x0, x1 ; Return RHS
end_265:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_262
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_83
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, val
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #5
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_268
    adr x0, sign_id ; Unit (False)
    b end_269
true_268:
    mov x0, x1 ; Return RHS
end_269:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_266
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_84
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_267
case_fail_266:
    adr x0, sign_id
case_end_267:
    b case_end_263
case_fail_262:
    adr x0, sign_id
case_end_263:
    b case_end_259
case_fail_258:
    adr x0, sign_id
case_end_259:
    b case_end_255
case_fail_254:
    adr x0, sign_id
case_end_255:
    adr x1, val
    str x0, [x1]
    b case_end_251
case_fail_250:
    adr x0, sign_id
case_end_251:
    adr x0, str_85
    adr x0, str_86
    adr x0, str_87
    adr x0, node
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, args
    str x0, [x1]
    adr x0, str_88
    adr x0, str_89
    adr x0, str_90
    adr x0, args
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, tail
    str x0, [x1]
    adr x0, tail
    ldr x0, [x0]
    adr x1, second_arg_exists
    str x0, [x1]
    adr x0, second_arg_exists
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_272
    adr x0, sign_id ; Unit (False)
    b end_273
true_272:
    mov x0, x1 ; Return RHS
end_273:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_270
    adr x0, str_91
    str x0, [sp, #-16]!  ; Push Func
    adr x0, child
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_275
    adr x0, args
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    str x0, [sp, #-16]!  ; Push Func
    adr x0, compile_node
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, child
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_21
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_279
    adr x0, sign_id ; Unit (False)
    b end_280
true_279:
    mov x0, x1 ; Return RHS
end_280:
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_277
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_92
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_278
case_fail_277:
    adr x0, sign_id
case_end_278:
    b case_end_276
case_fail_275:
    adr x0, sign_id
case_end_276:
match_end_274:
    b case_end_271
case_fail_270:
    adr x0, sign_id
case_end_271:
    adr x0, str_93
    adr x0, args
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, lhs
    str x0, [x1]
    adr x0, tail
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, rhs
    str x0, [x1]
    adr x0, compile_node
    str x0, [sp, #-16]!  ; Push Func
    adr x0, lhs
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_94
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, compile_node
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rhs
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_95
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_16
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_283
    adr x0, sign_id ; Unit (False)
    b end_284
true_283:
    mov x0, x1 ; Return RHS
end_284:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_281
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_96
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_282
case_fail_281:
    adr x0, sign_id
case_end_282:
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_17
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_287
    adr x0, sign_id ; Unit (False)
    b end_288
true_287:
    mov x0, x1 ; Return RHS
end_288:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_285
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_97
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_286
case_fail_285:
    adr x0, sign_id
case_end_286:
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_27
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_291
    adr x0, sign_id ; Unit (False)
    b end_292
true_291:
    mov x0, x1 ; Return RHS
end_292:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_289
    adr x0, emit
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_98
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_290
case_fail_289:
    adr x0, sign_id
case_end_290:
    adr x0, str_99
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_18
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_295
    adr x0, sign_id ; Unit (False)
    b end_296
true_295:
    mov x0, x1 ; Return RHS
end_296:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_293
    adr x0, str_100
    str x0, [sp, #-16]!  ; Push Func
    adr x0, name_char
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_298
    adr x0, lhs
    ldr x0, [x0]
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_101
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, _print_char
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, name_char
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, _print_str
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_18
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, _print_char
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #10
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_102
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, compile_node
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rhs
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_299
case_fail_298:
    adr x0, sign_id
case_end_299:
match_end_297:
    b case_end_294
case_fail_293:
    adr x0, sign_id
case_end_294:
    adr x0, str_103
    adr x0, op
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, str_19
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_302
    adr x0, sign_id ; Unit (False)
    b end_303
true_302:
    mov x0, x1 ; Return RHS
end_303:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_300
    adr x0, str_104
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_105
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, emit
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_106
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, emit
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_107
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, compile_node
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, rhs
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, emit
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_108
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, emit
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_109
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b case_end_301
case_fail_300:
    adr x0, sign_id
case_end_301:
    adr x0, sign_id
    b after_compile_block_304
compile_block:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_compile_block_304:
    adr x0, compile_block
    adr x0, nodes
    ldr x0, [x0]
    str x0, [sp, #-16]!
    adr x0, sign_id
    mov x1, x0
    ldr x0, [sp], #16
    cmp x0, x1
    b.eq true_307
    adr x0, sign_id ; Unit (False)
    b end_308
true_307:
    mov x0, x1 ; Return RHS
end_308:
    adr x9, sign_id
    cmp x0, x9
    b.eq case_fail_305
    adr x0, sign_id
    b case_end_306
case_fail_305:
    adr x0, sign_id
case_end_306:
    adr x0, nodes
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, head
    str x0, [x1]
    adr x0, nodes
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #1
    ldr x1, [sp], #16
    bl _nth
    adr x1, tail
    str x0, [x1]
    adr x0, compile_node
    str x0, [sp, #-16]!  ; Push Func
    adr x0, head
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, compile_block
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tail
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    b after_main_309
main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ; UNKNOWN OP: _
    mov sp, x29
    ldp x29, x30, [sp], #16
    ret
after_main_309:
    adr x0, main
    adr x0, _print_str
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_110
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, _print_char
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #10
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, read_all
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, source
    str x0, [x1]
    adr x0, tokenize
    str x0, [sp, #-16]!  ; Push Func
    adr x0, source
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, tokens
    str x0, [x1]
    adr x0, _print_str
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_111
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, _print_char
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #10
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, parse_block
    str x0, [sp, #-16]!  ; Push Func
    adr x0, tokens
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x1, res
    str x0, [x1]
    adr x0, res
    ldr x0, [x0]
    str x0, [sp, #-16]!
    mov x0, #0
    ldr x1, [sp], #16
    bl _nth
    adr x1, ast_list
    str x0, [x1]
    adr x0, _print_str
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_112
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, _print_char
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #10
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, compile_block
    str x0, [sp, #-16]!  ; Push Func
    adr x0, ast_list
    ldr x0, [x0]
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, _print_str
    str x0, [sp, #-16]!  ; Push Func
    adr x0, str_113
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, _print_char
    str x0, [sp, #-16]!  ; Push Func
    mov x0, #10
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    adr x0, main
    str x0, [sp, #-16]!  ; Push Func
    adr x0, sign_id
    mov x1, x0           ; Arg -> x1 (Wait, ABI says x0 is Arg1)
    ldr x9, [sp], #16    ; Pop Func -> x9
    mov x0, x1           ; Arg -> X0 (Standard Sign: 1 arg = X0)
    blr x9               ; Call Function
    mov x8, #93       ; svc exit
    svc #0

sign_id:
    ret

.data
str_0: .asciz "Unit/Empty List"
str_1: .asciz "Cons char to list"
str_2: .asciz "Only count space/tab, not newline (handled by caller)"
str_3: .asciz "EOF: Emit DEDENTs if indent > 0"
str_4: .asciz "For prototype, assume 1 level dedent at optional EOF or just end."
str_5: .asciz "Skip Spaces (Non-Newlines)"
str_6: .asciz "Check Newline"
str_7: .asciz "Compare Indent"
str_8: .asciz "Note: We assume indent increases by 1 'unit' or we track raw count?"
str_9: .asciz "Let's track raw count for now."
str_10: .asciz "Indent"
str_11: .asciz "Dedent"
str_12: .asciz "Same Indent -> Just continue"
str_13: .asciz "Normal Tokenize Logic (Pass current_indent)"
str_14: .asciz "Refactored to take indent param"
str_15: .asciz "Check specific chars"
str_16: .asciz "+"
str_17: .asciz "-"
str_18: .asciz ":"
str_19: .asciz "?"
str_20: .asciz "="
str_21: .asciz "!"
str_22: .asciz "Check Digit"
str_23: .asciz "ID"
str_24: .asciz "+ -"
str_25: .asciz "* /"
str_26: .asciz "! (Factorial)"
str_27: .asciz "*"
str_28: .asciz "/"
str_29: .asciz "End of Block"
str_30: .asciz "End of Block (Allow EOF to close)"
str_31: .asciz "Parse Expr"
str_32: .asciz "Recurse"
str_33: .asciz "Cons"
str_34: .asciz "Error"
str_35: .asciz "Wrap in [TOK_NUM, val]"
str_36: .asciz "Check Postfix Loop"
str_37: .asciz "Just return val (assume number/charcode for now)"
str_38: .asciz "For CodeGen to work, it needs to print this."
str_39: .asciz "If val is CharCode, we need to print char."
str_40: .asciz "Start of Block"
str_41: .asciz "Parse List"
str_42: .asciz "Wrap in TOK_BLOCK"
str_43: .asciz "TODO: Handle Parens"
str_44: .asciz "Error/Skip"
str_45: .asciz "Check if Postfix Op"
str_46: .asciz "False"
str_47: .asciz "Consume"
str_48: .asciz "Build Unary Node: [Op, LHS]"
str_49: .asciz "Correct List: Op, LHS, _"
str_50: .asciz "Loop"
str_51: .asciz "Check if it is an operator"
str_52: .asciz "Check Precedence"
str_53: .asciz "False (Unit) -> Return LHS"
str_54: .asciz "Consume Op"
str_55: .asciz "Parse RHS"
str_56: .asciz "Parse RHS Atom"
str_57: .asciz "Climb RHS"
str_58: .asciz "Build Node: [Op, LHS, RHS]"
str_59: .asciz "Correct List: Op, LHS, RHS, _"
str_60: .asciz "Loop / Continue Climbing"
str_61: .asciz "Not an op, return lhs"
str_62: .asciz "Parse Left"
str_63: .asciz "Climb"
str_64: .asciz "Check EOF"
str_65: .asciz "Cons result"
str_66: .asciz "Check if node is list ([op, args...])"
str_67: .asciz "If unit (End of block)"
str_68: .asciz "Try to access head (Op)"
str_69: .asciz "Check TOK_BLOCK"
str_70: .asciz "Check TOK_NUM"
str_71: .asciz "ldr x0, ="
str_72: .asciz "Wait, val is number. Need to print number?"
str_73: .asciz "For generated asm, we need text."
str_74: .asciz "If val is int, we need int-to-str runtime? Or just emit raw val if we have print_num?"
str_75: .asciz "Our emit takes string. We need _print_int for asm generation."
str_76: .asciz "Hack: Assume small number digit logic for now? Or implement int_to_str."
str_77: .asciz "Actually, emit passes string to _print_str."
str_78: .asciz "_print_str expects pointer."
str_79: .asciz "If we pass int to _print_str it crashes."
str_80: .asciz "Prototype Hack: Just emit placeholder for 1/2."
str_81: .asciz "mov x0, #1"
str_82: .asciz "mov x0, #2"
str_83: .asciz "mov x0, #3"
str_84: .asciz "mov x0, #5"
str_85: .asciz "If Op (is String?)"
str_86: .asciz "Binary: [Op, LHS, RHS, _]"
str_87: .asciz "Unary:  [Op, LHS, _]"
str_88: .asciz "Check Arity (Binary or Unary)"
str_89: .asciz "Binary has 2nd arg?"
str_90: .asciz "args: [lhs, [rhs, _]]"
str_91: .asciz "Unary Compilation"
str_92: .asciz "bl _factorial"
str_93: .asciz "Binary Compilation"
str_94: .asciz "str x0, [sp, #-16]!"
str_95: .asciz "ldr x1, [sp], #16"
str_96: .asciz "add x0, x1, x0"
str_97: .asciz "sub x0, x1, x0"
str_98: .asciz "mul x0, x1, x0"
str_99: .asciz "Definition: Name : RHS"
str_100: .asciz "Assume LHS is CharCode (ID)"
str_101: .asciz "Emit Label: char + :"
str_102: .asciz "Compile RHS"
str_103: .asciz "Function: Args ? Body"
str_104: .asciz "Args (LHS), Body (RHS)"
str_105: .asciz "Function Prologue/Epilogue?"
str_106: .asciz "    stp x29, x30, [sp, #-16]!"
str_107: .asciz "    mov x29, sp"
str_108: .asciz "    ldp x29, x30, [sp], #16"
str_109: .asciz "    ret"
str_110: .asciz "Enter Sign Code (Input): "
str_111: .asciz "Parsing Block..."
str_112: .asciz "Compiling Block..."
str_113: .asciz "Done."

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

_print_char:
    ; x0 = char code (number)
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    ; Store char on stack to get address
    str x0, [sp, #-16]!
    mov x1, sp        ; Buffer address
    mov x0, #1        ; FD = stdout
    mov x2, #1        ; Count = 1
    mov x8, #64       ; Syscall write
    svc #0
    
    add sp, sp, #16   ; Cleanup
    ldp x29, x30, [sp], #16
    ret
    
_print_str:
    ; x0 = string address (null terminated)
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x1, x0        ; Buffer
    ; Calculate length? Or assume we have length?
    ; 'asciz' is null terminated. We need strlen.
    mov x2, #0
.Lstrlen_loop:
    ldrb w3, [x1, x2]
    cbz w3, .Lstrlen_end
    add x2, x2, #1
    b .Lstrlen_loop
.Lstrlen_end:
    
    mov x0, #1        ; stdout
    mov x8, #64       ; write
    svc #0
    
    ldp x29, x30, [sp], #16
    ret
    
_read_char:
    ; Read 1 char from stdin (fd 0)
    ; Return char in x0, or -1 (EOF)
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    sub sp, sp, #16     ; Alloc buffer
    mov x1, sp          ; Buffer at [sp]
    mov x0, #0          ; FD = stdin
    mov x2, #1          ; Count = 1
    mov x8, #63         ; Syscall read
    svc #0
    
    ; Check result (x0)
    ; If x0 == 0 -> EOF
    ; If x0 < 0 -> Error
    cmp x0, #1
    b.ne .Lread_eof
    
    ldrb w0, [sp]       ; Load char
    b .Lread_end
    
.Lread_eof:
    mov x0, #-1         ; Return -1
    
.Lread_end:
    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

_str_at:
    ; x1 = string ptr, x0 = index
    ; Return char code at list[index]
    ; Note: Strings are C-strings (asciz)
    ldrb w0, [x1, x0]
    ret
TOK_EOF: .quad -1
TOK_NUM: .quad 1
TOK_ID: .quad 2
TOK_OP: .quad 3
TOK_INDENT: .quad 4
TOK_DEDENT: .quad 5
EOF: .quad -1
CHAR_SPACE: .quad 32
CHAR_NEWLINE: .quad 10
CHAR_TAB: .quad 9
CHAR_PLUS: .quad 43
CHAR_MINUS: .quad 45
CHAR_0: .quad 48
CHAR_9: .quad 57
c: .quad 0
rest: .quad 0
head: .quad 0
tail: .quad 0
id_val: .quad 0
PREC_NONE: .quad 0
PREC_ASSIGN: .quad 0
PREC_FUNC: .quad 0
PREC_COMPARE: .quad 0
PREC_TERM: .quad 0
PREC_FACTOR: .quad 0
PREC_POSTFIX: .quad 0
TOK_BLOCK: .quad 6
token: .quad 0
type: .quad 0
res: .quad 0
node: .quad 0
res2: .quad 0
nodes: .quad 0
final_rest: .quad 0
final_nodes: .quad 0
val: .quad 0
is_postfix: .quad 0
new_lhs: .quad 0
op: .quad 0
lhs: .quad 0
args: .quad 0
second_arg_exists: .quad 0
rhs: .quad 0
source: .quad 0
tokens: .quad 0
ast_list: .quad 0

.bss
heap_buffer: .skip 65536
