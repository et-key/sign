.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

func_with_defaults:
  // Unknown identifier: x
  // Unknown identifier: y
  ADD X0, X9, X10
  RET

result1_is_partial_applyed:
  // Unknown identifier: _
  BL func_with_defaults
  RET

result2_is_applied:
  MOV X0, #3
  BL func_with_defaults
  RET

result3_is_partial_applyed:
  RET

result4_is_applied:
  MOV X0, #3
  MOV X0, #5
L_block_end_0:
  BL func_with_defaults
  RET

result5_is_applied:
  MOV X9, #3
  MOV X10, #2
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  MOV X0, #5
L_block_end_1:
  BL func_with_defaults
  RET

result6_is_applied:
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
  RET

