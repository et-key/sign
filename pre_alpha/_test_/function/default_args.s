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
  // Unknown identifier: x
  // Unknown identifier: y
  ADD X0, X9, X10
  RET

result2_is_applied:
  // Unknown identifier: x
  // Unknown identifier: y
  ADD X0, X9, X10
  RET

result3_is_partial_applyed:
  RET

result4_is_applied:
  // Unknown identifier: Number
  RET

result5_is_applied:
  // Unknown identifier: Number
  RET

result6_is_applied:
  // Unknown identifier: Number
  RET

