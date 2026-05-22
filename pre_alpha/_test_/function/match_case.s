.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

func_match:
  // Unknown identifier: result1
  // Unknown identifier: result2
  MOV X0, #3
  RET

lambda_0:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  RET

