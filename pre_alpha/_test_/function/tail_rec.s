.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

loop:
  // Unknown identifier: x
  B loop
  RET

