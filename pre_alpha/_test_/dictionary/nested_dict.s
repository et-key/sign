.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

my_dict:
  // Unknown identifier: `Sign`
  MOV X0, #0.1
  // Unknown identifier: `Structural`
  // Unknown identifier: `AArch64`
L_block_end_0:
  RET

