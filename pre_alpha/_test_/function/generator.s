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
  LDR X0, [X9]
  // Unknown identifier: x
  // Unknown identifier: g
  B map
L_block_end_0:
  RET

result:
  // Unknown identifier: g
  LDR X0, [X9]
  // Unknown identifier: x
  // Unknown identifier: g
  BL map
L_block_end_1:
  RET

