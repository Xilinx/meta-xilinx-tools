#
# Copyright (C) 2016-2022, Xilinx, Inc.  All rights reserved.
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#

inherit xsctbase

FILESEXTRAPATHS:append := ":${XLNX_SCRIPTS_DIR}"

SRC_URI:append = " \
  file://dtgen.tcl \
  file://base-hsi.tcl \
"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

XSCTH_SCRIPT = "${WORKDIR}/dtgen.tcl"
