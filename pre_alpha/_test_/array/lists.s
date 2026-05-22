.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

a:
  MOV X0, #1
  RET

b:
  MOV X0, #2
  RET

c:
  MOV X0, #3
  RET

