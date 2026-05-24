.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

func_match:
  // Unknown identifier: x
  MOV X10, #1
  CMP X9, X10
  B.GE L_next_case_1
  // Unknown identifier: result1
  B L_block_end_0
L_next_case_1:
  // Unknown identifier: y
  MOV X10, #3
  CMP X9, X10
  B.GE L_next_case_2
  // Unknown identifier: result2
  B L_block_end_0
L_next_case_2:
  MOV X0, #3
L_block_end_0:
  RET

