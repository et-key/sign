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
  B L_arg_success_2
L_arg_fail_1:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_2:
  // Partial application of x not dynamically supported yet
  // Partial application of y not dynamically supported yet
  MOV X9, X0
  LDR X0, [X9]
  MOV X0, X1
  B map
L_block_end_0:
  RET

result:
  ADRP X0, lambda
  ADD X0, X0, :lo12:lambda
  MOV X0, #0
  MOV X1, #2
  MOV X2, #10
L_block_end_5:
  B L_arg_success_4
L_arg_fail_3:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_4:
  // Partial application of x not dynamically supported yet
  // Partial application of y not dynamically supported yet
  MOV X9, X0
  LDR X0, [X9]
  MOV X0, X1
  BL map
L_block_end_6:
  RET

