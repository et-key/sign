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
  // Unknown identifier: x
  // Unknown apply target
  // Unknown identifier: g
  B map
L_block_end_0:
  RET

result:
  ADRP X0, f
  ADD X0, X0, :lo12:f
  MOV X0, #0
  MOV X1, #2
  MOV X2, #10
L_block_end_1:
  BL map
  RET

