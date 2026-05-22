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
  // Unknown identifier: f
  // Unknown identifier: _
  MOV X0, #3
  RET

curried:
  MOV X0, #2
  BL f
  RET

result_curried:
  MOV X0, #4
  BL curried
  RET

check:
  RET

check2:
  RET

