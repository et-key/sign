.text
.global _start

_start:
  MOV X8, #93 // sys_exit
  MOV X0, #0
  SVC #0

f:
  // Unknown identifier: x
  MOV X10, #2
  MUL X0, X9, X10
  RET

map:
  // Unknown identifier: g
  LDR X0, [X9]
  // Unknown identifier: x
  // Unknown identifier: g
  B map
L_block_end_0:
  RET

result_map1:
  ADRP X9, lambda
  ADD X9, X9, :lo12:lambda
  LDR X0, [X9]
  MOV X0, #1
L_block_end_1:
  RET

result_map2:
  ADRP X9, [object Object]
  ADD X9, X9, :lo12:[object Object]
  LDR X0, [X9]
  MOV X0, #1
L_block_end_2:
  RET

result_sum:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_3:
  // Unknown apply target
  RET

result_partial:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_4:
  // Unknown apply target
  RET

test_array:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_5:
  RET

test_tuple:
  MOV X0, #1
  // Unknown identifier: a
  MOV X0, #3
L_block_end_6:
  RET

