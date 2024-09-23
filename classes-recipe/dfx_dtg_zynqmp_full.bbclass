#
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#
# This bbclass is inherited by ZynqMP Full bitstream loading firmware recipes.

inherit dfx_dtg_full_common

# Recipes that inherit from this class need to use an appropriate machine
# override for COMPATIBLE_MACHINE to build successfully, don't allow building
# for Zynq-7000, Versal and Versal-Net MACHINE.
COMPATIBLE_MACHINE:zynq = "^$"
COMPATIBLE_MACHINE:versal = "^$"
COMPATIBLE_MACHINE:versal-net = "^$"
