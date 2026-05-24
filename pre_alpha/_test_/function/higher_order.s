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

result_map1:
  ADRP X0, lambda
  ADD X0, X0, :lo12:lambda
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
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

result_map2:
  ADRP X0, [object Object]
  ADD X0, X0, :lo12:[object Object]
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_9:
  B L_arg_success_8
L_arg_fail_7:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_8:
  // Partial application of x not dynamically supported yet
  // Partial application of y not dynamically supported yet
  MOV X9, X0
  LDR X0, [X9]
  MOV X0, X1
  BL map
L_block_end_10:
  RET

result_sum:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_11:
  // Unknown apply target
  RET

result_partial:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_12:
  // Unknown apply target
  RET

test_array:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_13:
  RET

test_tuple:
  MOV X0, #1
  // Unknown identifier: a
  MOV X0, #3
L_block_end_14:
  RET

