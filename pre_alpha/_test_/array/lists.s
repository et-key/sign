.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

a:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #1
  LDP X29, X30, [SP], #16
  RET

b:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #2
  LDP X29, X30, [SP], #16
  RET

c:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #3
  LDP X29, X30, [SP], #16
  RET

