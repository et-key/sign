.text
.global _start

_start:
  BL result
  MOV X8, #93 // sys_exit
  SVC #0

f:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, X0
  MOV X10, #2
  MUL X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

g:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, X0
  MOV X10, #1
  ADD X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

result:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #3
  BL g
  BL f
  LDP X29, X30, [SP], #16
  RET

