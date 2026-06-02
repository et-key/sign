.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

f:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
f_body:
  B L_end_0
L_case_1:
  MOV X0, #10
L_end_0:
  LDP X29, X30, [SP], #16
  RET

g:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
g_body:
  B L_end_2
L_case_3:
L_end_2:
  LDP X29, X30, [SP], #16
  RET

a:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
a_body:
  // Unknown identifier: f
  LDP X29, X30, [SP], #16
  RET

b:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
b_body:
  // Unknown identifier: g
  LDP X29, X30, [SP], #16
  RET

