.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

io_handler:
  LDR X11, =0x40000004
  LDR X9, =0x40000000
  LDR X12, [X9]
  STR X12, [X11]
  RET

event_loop:
  // Unknown apply target
  RET

