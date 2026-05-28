.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

my_dict:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  // Unknown identifier: `Sign`
  B L_end_0
L_case_1:
  MOV X0, #0.1
  B L_end_0
L_case_2:
  // Unknown identifier: `Structural`
  B L_end_3
L_case_4:
  // Unknown identifier: `AArch64`
L_end_3:
L_end_0:
  LDP X29, X30, [SP], #16
  RET

