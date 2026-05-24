.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

loop:
  // Unknown identifier: x
  B L_arg_success_1
L_arg_fail_0:
  // Implicit Unit short-circuit (no failLabel)
L_arg_success_1:
  B loop
  RET

