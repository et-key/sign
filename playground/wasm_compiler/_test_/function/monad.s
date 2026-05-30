.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

f:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
f_body:
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

maybe_val:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
maybe_val_body:
  MOV X9, #10
  MOV X10, #5
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  LDP X29, X30, [SP], #16
  RET

mapped:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
mapped_body:
  // Unknown identifier: maybe_val
  MOV X0, #3
L_block_end_0:
  BL f
  LDP X29, X30, [SP], #16
  RET

g:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
g_body:
  MOV X9, X0
  MOV X10, #2
  MUL X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

mapped_twice:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
mapped_twice_body:
  // Unknown identifier: mapped
  BL g
  LDP X29, X30, [SP], #16
  RET

