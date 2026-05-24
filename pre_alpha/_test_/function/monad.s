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
  RET

mapped:
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

g:
  // Unknown identifier: x
  MOV X10, #2
  MUL X0, X9, X10
  RET

mapped_twice:
  MOV X0, #3
L_block_end_7:
  B L_arg_success_6
L_arg_fail_5:
  B L_arg_fail_3 // Implicit Unit short-circuit
L_arg_success_6:
  // Partial application of y not dynamically supported yet
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  B L_arg_success_4
L_arg_fail_3:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_4:
  MOV X9, X0
  MOV X10, #2
  MUL X0, X9, X10
  RET

