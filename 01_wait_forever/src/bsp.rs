// SPDX-License-Identifier: MIT OR Apache-2.0
//
// Copyright (c) 2018-2021 Andre Richter <andre.o.richter@gmail.com>

//! Conditional reexporting of Board Support Packages.

#[cfg(any(feature = "bsp_rpi3", feature = "bsp_rpi4"))]
mod raspberrypi;

#[cfg(any(feature = "bsp_rpi3", feature = "bsp_rpi4"))]
pub use raspberrypi::*;

#[cfg(any(feature = "bsp_k210"))]
mod k210;

#[cfg(any(feature = "bsp_k210"))]
pub use k210::*;
