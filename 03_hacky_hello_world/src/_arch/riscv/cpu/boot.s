// SPDX-License-Identifier: MIT OR Apache-2.0
//
// Copyright (c) 2021 Andre Richter <andre.o.richter@gmail.com>

//--------------------------------------------------------------------------------------------------
// Public Code
//--------------------------------------------------------------------------------------------------
.equ _core_id_mask, 0b11

.section .text._start
.globl	_start
//------------------------------------------------------------------------------
// fn _start()
//------------------------------------------------------------------------------
_start:
	csrr x5, mhartid
	andi	x5, x5, _core_id_mask
	li	x6, 0
	bne	x5, x6, .L_parking_loop

	la	x5, __bss_start
	la x6, __bss_end_exclusive
	// Infinitely wait for events (aka "park the core").
.L_bss_init_loop:
	# cmp	x0, x1
	beq	x5, x6, .L_prepare_rust
	# stp	x0, x0, [x5], #16  # todo
	j	.L_bss_init_loop

	// Prepare the jump to Rust code.
.L_prepare_rust:
	// Set the stack pointer.
	la sp, __boot_core_stack_end_exclusive

	// Jump to Rust code.
	j	_start_rust

	// Infinitely wait for events (aka "park the core").
.L_parking_loop:
	wfi
	j	.L_parking_loop
