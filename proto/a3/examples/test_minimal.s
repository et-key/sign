; Compiler Explorer output for test_minimal.ll
; x86-64 clang (trunk) with -O2 optimization

main:                                   # @main
        mov     qword ptr [rsp - 8], 42
        mov     qword ptr [rsp - 16], -10
        mov     qword ptr [rsp - 24], 3
        mov     qword ptr [rsp - 32], 7
        mov     qword ptr [rsp - 40], 20
        mov     qword ptr [rsp - 48], 5
        mov     qword ptr [rsp - 56], 14
        mov     qword ptr [rsp - 64], 1
        mov     qword ptr [rsp - 72], 1
        mov     rax, qword ptr [rip + .str.1@GOTPCREL]
        mov     qword ptr [rsp - 80], rax
        ret
.str.1:
        .asciz  "Hello, LLVM!"
