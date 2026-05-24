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
  MOV X0, #1
  MOV X9, X0
  MOV X10, #1
  ADD X1, X9, X10
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  RET

result2:
  MOV X0, #3
  B L_arg_success_1
L_arg_fail_0:
  MOV X0, #1
L_arg_success_1:
  MOV X9, X0
  MOV X10, #1
  ADD X1, X9, X10
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  RET

result3:
  RET

result4:
  MOV X0, #3
  MOV X0, #5
L_block_end_4:
  B L_arg_success_3
L_arg_fail_2:
  MOV X0, #1
L_arg_success_3:
  MOV X9, X0
  MOV X10, #1
  ADD X1, X9, X10
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  RET

result5:
  MOV X0, #5
L_block_end_7:
  B L_arg_success_6
L_arg_fail_5:
  MOV X0, #1
L_arg_success_6:
  MOV X9, X0
  MOV X10, #1
  ADD X1, X9, X10
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  RET

result6:
L_block_end_10:
  B L_arg_success_9
L_arg_fail_8:
  MOV X0, #1
L_arg_success_9:
  MOV X9, X0
  MOV X10, #1
  ADD X1, X9, X10
  MOV X9, X0
  MOV X10, X1
  ADD X0, X9, X10
  RET

