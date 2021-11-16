// SPDX-License-Identifier: MIT OR Apache-2.0
//
// Copyright (c) 2021 Andre Richter <andre.o.richter@gmail.com>

//--------------------------------------------------------------------------------------------------
// Public Code
//--------------------------------------------------------------------------------------------------
.section .text._start
.globl	_start
//------------------------------------------------------------------------------
// fn _start()
//------------------------------------------------------------------------------
_start:
	// Infinitely wait for events (aka "park the core").
.L_parking_loop:
	wfi
	j	.L_parking_loop


