ENTRY(_start)
SECTIONS {
	. = 0x40080000;
	.text  : { *(.text*) }
	/* ### (Pin) が出す固定配置セクション。本来は option.ms の `base` が住所を決める
	   （system_architecture.md §2.2）——ここは検証用なので .text の直後に置くだけ。 */
	.sign.pinned : { *(.sign.pinned*) }
	.rodata : { *(.rodata*) }
	.data  : { *(.data*) }
	.bss   : { *(.bss*) }
	. = ALIGN(16);
	. = . + 0x10000;
	_stack_top = .;
}
