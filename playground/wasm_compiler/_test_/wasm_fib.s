.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

fib:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
fib_body:
  MOV X9, X0
  MOV X10, #2
  CMP X9, X10
  B.GE L_next_case_2
L_next_case_2:
  B L_end_0
L_case_1:
  // Unknown identifier: ``
  MOV X9, X0
  MOV X10, #1
  SUB X0, X9, X10
  BL fib
  MOV X9, X0
  MOV X9, X0
  MOV X10, #2
  SUB X0, X9, X10
  BL fib
  MOV X10, X0
  ADD X0, X9, X10
L_block_end_3:
L_end_0:
  LDP X29, X30, [SP], #16
  RET

