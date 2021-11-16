/* SPDX-License-Identifier: MIT OR Apache-2.0
 *
 * Copyright (c) 2018-2021 Andre Richter <andre.o.richter@gmail.com>
 */

/* The address at which the the kernel binary will be loaded by the Raspberry's firmware */

OUTPUT_ARCH(riscv)
__k210_load_addr = 0x80000000;
ENTRY(__k210_load_addr)

PHDRS
{
    segment_rx PT_LOAD FLAGS(6); /* 6 == RX */
}
SECTIONS
{
    . =  __k210_load_addr;
                                        /*   ^             */
                                        /*   | stack       */
                                        /*   | growth      */
                                        /*   | direction   */
   __boot_core_stack_end_exclusive = .; /*   |             */
    /***********************************************************************************************
    * Code + RO Data + Global Offset Table
    ***********************************************************************************************/
     .text :
    {
        KEEP(*(.text._start))
        *(.text._start_arguments) /* Constants (or statics in Rust speak) read by _start(). */
        *(.text._start_rust)      /* The Rust entry point */
        *(.text*)                 /* Everything else */
    } :segment_rx

    .rodata : ALIGN(8) { *(.rodata*) } :segment_rx
    .got    : ALIGN(8) { *(.got)     } :segment_rx

    /***********************************************************************************************
    * Data + BSS
    ***********************************************************************************************/
    .data : { *(.data*) } :segment_rw

    /* Section is zeroed in pairs of u64. Align start and end to 16 bytes */
    .bss : ALIGN(16)
    {
        __bss_start = .;
        *(.bss*);
        . = ALIGN(16);
        __bss_end_exclusive = .;
    } :NONE
}