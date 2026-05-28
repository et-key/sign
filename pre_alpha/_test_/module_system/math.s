.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

sub:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
sub_body:
  SUB X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

