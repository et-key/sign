// Sign のコードを裸の AArch64 で走らせるための最小の入口。
//
// `-M virt` の RAM は 0x40000000 から。UART（PL011）は 0x9000000 に居るので、
// 返値をそこへ16進で書き出してから semihosting で抜ける。OS は要らない——
// Sign が最終的に降りていく先がここなので、確かめる場所もここでよい。
	.text
	.global _start
_start:
	ldr x0, =_stack_top
	mov sp, x0
	bl _sign_main
	mov x20, x0
	mov x21, x1
	mov x22, x2
	mov x23, x3
	mov x0, x20
	bl put_hex
	mov x0, x21
	bl put_hex
	mov x0, x22
	bl put_hex
	mov x0, x23
	bl put_hex
	// semihosting で終了する。x1 は {理由, 終了コード} の組。
	adrp x1, .Lexit
	add x1, x1, :lo12:.Lexit
	mov x0, #0x18
	hlt #0xF000
1:	b 1b

// x0 を16進16桁＋改行で UART へ流す。
put_hex:
	mov x2, #0x9000000
	mov x3, #60
1:	lsr x4, x0, x3
	and x4, x4, #0xf
	cmp x4, #10
	add x5, x4, #48
	add x6, x4, #87
	csel x5, x5, x6, lo
	str w5, [x2]
	subs x3, x3, #4
	b.pl 1b
	mov w5, #10
	str w5, [x2]
	ret

	.section .rodata
	.balign 8
.Lexit:
	.quad 0x20026        // ADP_Stopped_ApplicationExit
	.quad 0
