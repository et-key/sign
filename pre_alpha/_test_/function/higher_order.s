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
  ADD X9, X2, X3 // new current
  MOV X1, X2 // yield current
  MOV X2, X9 // next state
  BL map
  // Unknown apply target
  RET

result_map1:
  ADRP X0, f
  ADD X0, X0, :lo12:f
  MOV X1, #1
  BL map
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
  RET

result_map2:
  ADRP X0, [object Object]
  ADD X0, X0, :lo12:[object Object]
  MOV X1, #1
  BL map
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
  RET

result_sum:
  ADD X0, X9, X10
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
  RET

result_partial:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
  RET

test_array:
  MOV X0, #1
  MOV X0, #2
  MOV X0, #3
  MOV X0, #4
  MOV X0, #5
  RET

test_tuple:
  MOV X0, #1
  // Unknown identifier: a
  MOV X0, #3
  RET

lambda_0:
  // Unknown identifier: x
  MOV X10, #2
  MUL X0, X9, X10
  RET

