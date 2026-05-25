.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

f:
  // Unknown identifier: x
  // Unknown identifier: y
  ADD X0, X9, X10
  RET

maybe_val:
  RET

mapped:
  RET

g:
  // Unknown identifier: x
  MOV X10, #2
  MUL X0, X9, X10
  RET

mapped_twice:
  RET

