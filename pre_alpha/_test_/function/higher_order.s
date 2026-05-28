.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

f:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X9, X0
  MOV X10, #2
  MUL X0, X9, X10
  LDP X29, X30, [SP], #16
  RET

map:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, X1
  // Unknown apply target
  LDP X29, X30, [SP], #16
  B map
L_block_end_0:
  LDP X29, X30, [SP], #16
  RET

result_map1:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  ADRP X0, f
  ADD X0, X0, :lo12:f
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_1:
  BL map
  LDP X29, X30, [SP], #16
  RET

result_map2:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  ADRP X0, [object Object]
  ADD X0, X0, :lo12:[object Object]
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_2:
  BL map
  LDP X29, X30, [SP], #16
  RET

result_sum:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_3:
  // Unknown apply target
  LDP X29, X30, [SP], #16
  RET

result_partial:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_4:
  // Unknown apply target
  LDP X29, X30, [SP], #16
  RET

test_array:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_5:
  LDP X29, X30, [SP], #16
  RET

test_tuple:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
  MOV X0, #1
  // Unknown identifier: a
  MOV X0, #3
L_block_end_6:
  LDP X29, X30, [SP], #16
  RET

