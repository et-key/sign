.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

add10:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
add10_body:
  MOV X9, X0
  MOV X10, #10
  ADD X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

apply_to_20:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
apply_to_20_body:
  MOV X0, #20
L_block_end_0:
  LDP X29, X30, [SP], #16
  RET

