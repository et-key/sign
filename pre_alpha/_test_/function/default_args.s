.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

func_with_defaults:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

result1_is_partial_applyed:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  // Unknown identifier: _
  BL func_with_defaults
  LDP X29, X30, [SP], #16
  RET

result2_is_applied:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #3
  BL func_with_defaults
  LDP X29, X30, [SP], #16
  RET

result3_is_partial_applyed:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  LDP X29, X30, [SP], #16
  RET

result4_is_applied:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #3
  MOV X0, #5
L_block_end_0:
  BL func_with_defaults
  LDP X29, X30, [SP], #16
  RET

result5_is_applied:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, #3
  MOV X10, #2
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  MOV X0, #5
L_block_end_1:
  BL func_with_defaults
  LDP X29, X30, [SP], #16
  RET

result6_is_applied:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, #3
  MOV X10, #2
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  MOV X9, #5
  MOV X10, #2
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
L_block_end_2:
  BL func_with_defaults
  LDP X29, X30, [SP], #16
  RET

