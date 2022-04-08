OUTPUT_ARCH(riscv)
ENTRY(_start)
BASE_ADDRESS = 0x80000000;

SECTIONS
{
    . = BASE_ADDRESS;
     __boot_core_stack_end_exclusive = .; 
    .text : {
        *(.text._start)
         *(.text._start_arguments) /* Constants (or statics in Rust speak) read by _start(). */
        *(.text._start_rust)      /* The Rust entry point */
        *(.text .text.*)
    }

    . = ALIGN(4K);

    .rodata : {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    }

    . = ALIGN(4K);

    .data : {
        *(.data .data.*)
        *(.sdata .sdata.*)
    }

    . = ALIGN(4K);

    .bss : {
        __bss_start = .;
        *(.bss.stack)
        *(.bss .bss.*)
        *(.sbss .sbss.*)
         __bss_end_exclusive = .;
    }

    . = ALIGN(4K);

    /DISCARD/ : {
        *(.eh_frame)
    }
}