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

partial:
  // Unknown identifier: _
  RET

curried:
  // Unknown identifier: x
  // Unknown identifier: y
  ADD X0, X9, X10
  RET

result_curried:
  // Unknown identifier: Number
  RET

check:
  RET

check2:
  MOV X9, #5
  MOV X10, #5
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  RET

