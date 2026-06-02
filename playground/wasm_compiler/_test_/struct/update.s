.text
.global _start

_start:
  MOV X0, #0
  MOV X8, #93 // sys_exit
  SVC #0

x:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
x_body:
  MOV X0, #10
  LDP X29, X30, [SP], #16
  RET

y:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
y_body:
  MOV X0, #20
  LDP X29, X30, [SP], #16
  RET

z:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
z_body:
  MOV X0, #30
  LDP X29, X30, [SP], #16
  RET

point:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
point_body:
  // Unknown identifier: x
  B L_end_0
L_case_1:
  // Unknown identifier: y
  B L_end_0
L_case_2:
  // Unknown identifier: z
L_end_0:
  LDP X29, X30, [SP], #16
  RET

update_x:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
update_x_body:
  MOV X0, #100
  B L_end_3
L_case_4:
  MOV X9, X1
  MOV X0, X9 // Advance state (stub)
L_end_3:
  LDP X29, X30, [SP], #16
  RET

new_point:
  STP X29, X30, [SP, #-16]!
  MOV X29, SP
new_point_body:
  // Unknown identifier: point
  BL update_x
  LDP X29, X30, [SP], #16
  RET

