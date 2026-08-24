ENTRY(_start)
SECTIONS {
	. = 0x40080000;
	.text  : { *(.text*) }
	.rodata : { *(.rodata*) }
	.data  : { *(.data*) }
	.bss   : { *(.bss*) }
	. = ALIGN(16);
	. = . + 0x10000;
	_stack_top = .;
}
