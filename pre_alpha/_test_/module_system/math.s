.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

add:
  ADD X0, X9, X10
  RET

sub:
  SUB X0, X9, X10
  RET

