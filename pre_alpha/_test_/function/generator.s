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

map:
  // Unknown identifier: g
  ADD X9, X2, X3 // new current
  MOV X1, X2 // yield current
  MOV X2, X9 // next state
  BL map
  // Unknown apply target
  RET

result:
  ADRP X0, f
  ADD X0, X0, :lo12:f
  MOV X1, #0
  MOV X2, #2
  MOV X3, #10
  BL map
  RET

