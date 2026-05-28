.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

f:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

partial:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  // Unknown identifier: _
  MOV X0, #3
L_block_end_0:
  BL f
  LDP X29, X30, [SP], #16
  RET

curried:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #2
  BL f
  LDP X29, X30, [SP], #16
  RET

result_curried:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  // Unknown identifier: curried
  MOV X0, #4
L_block_end_1:
  LDP X29, X30, [SP], #16
  RET

check:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, #10
  MOV X10, #5
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  LDP X29, X30, [SP], #16
  RET

check2:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, #5
  MOV X10, #5
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  LDP X29, X30, [SP], #16
  RET

