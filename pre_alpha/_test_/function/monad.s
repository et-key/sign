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
  MOV X9, #10
  MOV X10, #5
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  RET

mapped:
  // Unknown identifier: maybe_val
  MOV X0, #3
L_block_end_0:
  BL f
  RET

g:
  // Unknown identifier: x
  MOV X10, #2
  MUL X0, X9, X10
  RET

mapped_twice:
  // Unknown identifier: mapped
  BL g
  RET

