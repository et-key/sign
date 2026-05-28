.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

echo_loop:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
echo_loop_body:
  MOV X9, X0
  MOV X0, X9 // Advance state (stub)
  MOV X11, X1
  MOV X9, X0
  LDR X12, [X9]
  STR X12, [X11]
  MOV X0, X11 // Return updated stream state
L_block_end_0:
  B echo_loop_body
  LDP X29, X30, [SP], #16
  RET

