.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

x:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
x_body:
  MOV X0, #5
  LDP X29, X30, [SP], #16
  RET

