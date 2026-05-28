.text
.global _start

_start:
  BL result
  MOV X8, #93 // sys_exit
  SVC #0

f:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
f_body:
  MOV X9, X0
  MOV X10, #2
  MUL X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

map:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
map_body:
  MOV X0, X1
  // Unknown apply target
  MOV X9, X2
  MOV X0, X9 // Advance state (stub)
  B map_body
L_block_end_0:
  LDP X29, X30, [SP], #16
  RET

result:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
result_body:
  ADRP X0, f
  ADD X0, X0, :lo12:f
  MOV X0, #0
  MOV X1, #2
  MOV X2, #10
L_block_end_1:
  BL map
  LDP X29, X30, [SP], #16
  RET

