.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

f:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
f_body:
  B L_end_0
L_case_1:
  MOV X0, #5
  BLR X0
L_end_0:
  LDP X29, X30, [SP], #16
  RET

