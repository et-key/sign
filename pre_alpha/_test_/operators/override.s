.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

[object Object]:
  // Unknown identifier: _
  RET

[object Object]:
  // Unknown identifier: String
  RET

