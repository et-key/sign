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

partial:
  // Unknown identifier: _
  MOV X0, #3
L_block_end_2:
  B L_arg_success_1
L_arg_fail_0:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_1:
  // Partial application of y not dynamically supported yet
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  RET

curried:
  MOV X0, #2
  B L_arg_success_4
L_arg_fail_3:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_4:
  // Partial application of y not dynamically supported yet
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  RET

result_curried:
  MOV X0, #2
  B L_arg_success_6
L_arg_fail_5:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_6:
  MOV X1, #4
  B L_arg_success_8
L_arg_fail_7:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_8:
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  RET

check:
  RET

check2:
  MOV X9, #5
  MOV X10, #5
  CMP X9, X10
  // No failLabel provided for Unit fallback
  MOV X0, X9
  RET

