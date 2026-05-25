.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

f:
  // Unknown identifier: x
  MOV X10, #2
  MUL X0, X9, X10
  RET

g:
  // Unknown identifier: x
  MOV X10, #1
  ADD X0, X9, X10
  RET

result:
  // Unknown identifier: Number
  RET

