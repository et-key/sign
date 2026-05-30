.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

io_handler:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
io_handler_body:
  LDR X11, =0x40000004
  LDR X9, =0x40000000
  LDR X12, [X9]
  STR X12, [X11]
  MOV X0, X11 // Return updated stream state
  LDP X29, X30, [SP], #16
  RET

event_loop:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
event_loop_body:
  // Unknown apply target
  LDP X29, X30, [SP], #16
  RET

