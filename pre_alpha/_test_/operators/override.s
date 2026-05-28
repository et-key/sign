.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

[object Object]:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
[object Object]_body:
  // Unknown identifier: _
  LDP X29, X30, [SP], #16
  RET

[object Object]:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
[object Object]_body:
  // Unknown identifier: String
  LDP X29, X30, [SP], #16
  RET

