# Implementation Guidelines

This document describes the guidelines for implementing the floating point unit (FPU) project.


## Naming Convention

`fpu` is the top-level module, and for each module that differs between the single-precision and double-precision versions, we will use the following naming convention: `fpu_sp` and `fpu_dp` for the single-precision and double-precision versions respectively.	

For each module that differ from the operation, we will use the following naming convention: `fpu_sp_op` and `fpu_dp_op` for the single-precision and double-precision versions respectively, where `op` is the operation name.

For testbenches modules, we will add `tb` to the beginning of the module name(`tb_fpu`).