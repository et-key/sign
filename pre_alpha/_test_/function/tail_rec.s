.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

loop:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
loop_body:
  B loop_body
  LDP X29, X30, [SP], #16
  RET

