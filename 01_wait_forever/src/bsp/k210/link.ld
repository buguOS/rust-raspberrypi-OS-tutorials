/* SPDX-License-Identifier: MIT OR Apache-2.0
 *
 * Copyright (c) 2018-2021 Andre Richter <andre.o.richter@gmail.com>
 */

/* The address at which the the kernel binary will be loaded by the Raspberry's firmware */

OUTPUT_ARCH(riscv)
__k210_load_addr = 0x80000000;
ENTRY(__k210_load_addr)
SECTIONS
{
    . =  __k210_load_addr;

    /***********************************************************************************************
    * Code
    ***********************************************************************************************/
 .text :
    {
        KEEP(*(.text._start))
    }
}
