.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

map:
  // Unknown identifier: g
  ADD X9, X2, X3 // new current
  MOV X1, X2 // yield current
  MOV X2, X9 // next state
  BL map
  // Unknown apply target
  RET

io_handler:
  LDR X11, =0x40000004
  LDR X9, =0x40000000
  LDR X12, [X9]
  STR X12, [X11]
  RET

event_loop:
  ADRP X0, io_handler
  ADD X0, X0, :lo12:io_handler
  MOV X1, #0
  MOV X2, #1
  MOV X3, #10
  BL map
  RET

