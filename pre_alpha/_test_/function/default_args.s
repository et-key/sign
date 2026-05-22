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

result1:
  // Unknown identifier: ..
  // Unknown identifier: ..
  BL func_with_defaults
  RET

result2:
  // Unknown identifier: func_with_defaults
  MOV X0, #3
  // Unknown identifier: ..
  RET

result3:
  // Unknown identifier: ..
  MOV X1, #5
  BL func_with_defaults
  RET

result4:
  // Unknown identifier: func_with_defaults
  MOV X0, #3
  MOV X0, #5
  RET

result5:
  RET

result6:
  RET

