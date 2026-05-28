.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

all_func:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
all_func_body:
  MOV X9, X0
  MOV X10, #0
  CMP X9, X10
  B.NE L_next_case_2
  MOV X0, #2
  MOV X9, X2
  MOV X0, X9 // Advance state (stub)
L_block_end_3:
  BL all_func
L_next_case_2:
  B L_end_0
L_case_1:
  MOV X9, X0
  MOV X10, #1
  CMP X9, X10
  B.NE L_next_case_5
L_next_case_5:
  B L_end_0
L_case_4:
  MOV X9, X1
  MOV X10, #0
  CMP X9, X10
  B.NE L_next_case_7
  MOV X0, X1
L_next_case_7:
  B L_end_0
L_case_6:
  MOV X9, X0
  MOV X10, X1
  MUL X0, X9, X10
L_end_0:
  LDP X29, X30, [SP], #16
  RET

