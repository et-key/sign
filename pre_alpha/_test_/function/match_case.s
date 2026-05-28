.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

func_match:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, X0
  MOV X10, #1
  CMP X9, X10
  B.GE L_next_case_1
  // Unknown identifier: `result1`
  B L_block_end_0
L_next_case_1:
  MOV X9, X1
  MOV X10, #3
  CMP X9, X10
  B.GE L_next_case_2
  // Unknown identifier: `result2`
  B L_block_end_0
L_next_case_2:
  // Unknown identifier: ``
  MOV X9, X0
  MOV X10, X1
  MUL X0, X9, X10
L_block_end_0:
  LDP X29, X30, [SP], #16
  RET

