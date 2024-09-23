#
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#
# This bbclass is inherited by Versal DFx Partial firmware app recipes.

inherit dfx_dtg_partial_common

# Recipes that inherit from this class need to use an appropriate machine
# override for COMPATIBLE_MACHINE to build successfully, don't allow building
# for Zynq-7000 and ZynqMP MACHINE.
COMPATIBLE_MACHINE:zynqmp = "^$"