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
  // Unknown identifier: x
  // Unknown apply target
  // Unknown identifier: g
  B map
L_block_end_0:
  RET

result_map1:
  ADRP X0, f
  ADD X0, X0, :lo12:f
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_1:
  BL map
  RET

result_map2:
  ADRP X0, [object Object]
  ADD X0, X0, :lo12:[object Object]
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
L_block_end_2:
  BL map
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

